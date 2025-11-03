import 'package:get/get.dart';


import '../../../core/constants/app/app_assets.dart';
import '../../../core/controllers/selection_controller.dart';

class FaceController extends GetxController {
  final RxString currentFaceImage = AppAssets.face.obs;

  final RxString selectedButton = ''.obs;
  void changeFaceImage(String faceType) {
    selectedButton.value = faceType.toLowerCase();
    final selection = Get.put(SelectionController());

    switch (faceType.toLowerCase()) {
      case 'down':
        currentFaceImage.value = AppAssets.down;
        selection.setSelectedZone('Bozo');
      case 'cheeks':
        currentFaceImage.value = AppAssets.cheeks;
        selection.setSelectedZone('Mejillas');
      case 'neck':
        currentFaceImage.value = AppAssets.faceNeck;
        selection.setSelectedZone('Cuello');
      default:
        currentFaceImage.value = AppAssets.face;
        selectedButton.value = '';
        selection.setSelectedZone('');
    }
  }

  void resetFaceImage() {
    currentFaceImage.value = AppAssets.face;
  }
}
