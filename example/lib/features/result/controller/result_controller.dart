import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../core/api/models/analysis_response.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../core/controllers/selection_controller.dart';
import '../../../core/services/ultrascan_result_service.dart';

class ResultController extends BaseController {
  ResultController({required this.analysisResponse});
  final AnalysisResponse analysisResponse;

  final RxString submitMessage = ''.obs;
  final UltrascanResultService _service = UltrascanResultService();
  static const String _macAddressKey = 'saved_mac_address';

  @override
  void onInit() {
    super.onInit();
    _submitToMedicompras();
  }

  Future<void> _submitToMedicompras() async {
    try {
      final selection = Get.put(SelectionController());
      final zone = selection.selectedZone.value;
      if (zone.isEmpty || analysisResponse.analysis == null) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final mac = prefs.getString(_macAddressKey);
      if (mac == null || mac.isEmpty) {
        submitMessage.value = 'MAC not set';
        return;
      }

      final piel = analysisResponse.analysis!.skinColor?.value ?? 0;
      final color = analysisResponse.analysis!.hairColor?.value ?? 0;
      final thickNum = analysisResponse.analysis!.hairThickness?.value ?? 0.0;
      final thick = double.parse(thickNum.toStringAsFixed(2));

      final resp = await _service.submitResult(
        macAddress: mac,
        piel: piel,
        color: color,
        thick: thick,
        zone: zone,
      );
      debugPrint(resp.toString());
      final data = resp.data;
      String message;
      if (data is Map) {
        message =
            (data['Results'] ??
                    data['results'] ??
                    data['message'] ??
                    data['Message'] ??
                    data)
                .toString();
      } else if (data is String) {
        message = data;
      } else {
        message = data.toString();
      }
      debugPrint(message);
      submitMessage.value = message;
    } catch (e) {
      submitMessage.value = 'Failed to send';
    }
  }
}
