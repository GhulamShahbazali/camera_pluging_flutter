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
  final UltrascanResultService service = UltrascanResultService();
  static const String _macAddressKey = 'saved_mac_address';
  RxString resultLink = ''.obs;

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

      final resp = await service.resultLink(
        macAddress: mac,

        piel: piel.round(),
        color: color.round(),

        thick: thick,
        zone: zone,
      );
      debugPrint(resp.toString());
      resultLink.value = resp;
    } catch (e) {
      submitMessage.value = 'Failed to send';
    }
  }
}
