import 'package:get/get.dart';

class SelectionController extends GetxController {
  final RxString selectedZone = ''.obs;

  Future<void> setSelectedZone(String zone) async {
    selectedZone.value = zone;
  }
}
