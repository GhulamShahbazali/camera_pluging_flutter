import 'package:get/get.dart';

import '../../../core/constants/app/app_assets.dart';
import '../../../core/controllers/selection_controller.dart';


class BackController extends GetxController {
  final RxString currentBackImage = AppAssets.dorsal.obs;

  final RxString selectedButton = ''.obs;
  void changeBackImage(String backType) {
    selectedButton.value = backType.toLowerCase();
    final selection = Get.put(SelectionController());

    switch (backType.toLowerCase()) {
      case 'neck':
        currentBackImage.value = AppAssets.dorsalNeck;
        selection.setSelectedZone('Cuello');
      case 'shoulders':
        currentBackImage.value = AppAssets.sholders;
        selection.setSelectedZone('Hombros');
      case 'back':
        currentBackImage.value = AppAssets.back;
        selection.setSelectedZone('Espalda');
      case 'glutes':
        currentBackImage.value = AppAssets.glutes;
        selection.setSelectedZone('Gluteos');
      default:
        currentBackImage.value = AppAssets.dorsal;
        selectedButton.value = '';
        selection.setSelectedZone('');
    }
  }

  void resetBackImage() {
    currentBackImage.value = AppAssets.face;
  }
}
