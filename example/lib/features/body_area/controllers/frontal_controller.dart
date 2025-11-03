import 'package:get/get.dart';


import '../../../core/constants/app/app_assets.dart';
import '../../../core/controllers/selection_controller.dart';

class FrontalController extends GetxController {
  final RxString currentFrontalImage = AppAssets.frontal.obs;

  final RxString selectedButton = ''.obs;
  void changeFrontalImage(String bodyPart) {
    selectedButton.value = bodyPart.toLowerCase();
    final selection = Get.put(SelectionController());

    switch (bodyPart.toLowerCase()) {
      case 'peco':
        currentFrontalImage.value = AppAssets.peco;
        selection.setSelectedZone('Pecho');
      case 'armpits':
        currentFrontalImage.value = AppAssets.armpits;
        selection.setSelectedZone('Axilas');
      case 'bikini':
        currentFrontalImage.value = AppAssets.bikini;
        selection.setSelectedZone('Bikini');
      case 'lowerleg':
        currentFrontalImage.value = AppAssets.lowerLeg;
        selection.setSelectedZone('Pierna');
      case 'arms':
        currentFrontalImage.value = AppAssets.arms;
        selection.setSelectedZone('Brazos');
      case 'abdomen':
        currentFrontalImage.value = AppAssets.abdomen;
        selection.setSelectedZone('Abdomen');
      case 'thighs':
        currentFrontalImage.value = AppAssets.thighs;
        selection.setSelectedZone('Muslos');
      default:
        currentFrontalImage.value = AppAssets.frontal;
        selectedButton.value = '';
        selection.setSelectedZone('');
    }
  }

  void resetFrontalImage() {
    currentFrontalImage.value = AppAssets.frontal;
  }
}
