import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/face_controller.dart';
import '../../widget/text_button.dart';


class FacePage extends StatelessWidget {
  const FacePage({super.key});

  Widget _buildPositionedButton({
    required double top,
    required double horizontalOffset,
    required bool isLeft,
    required String text,
    required String faceType,
    required FaceController controller,
  }) {
    return Positioned(
      top: top,
      left: isLeft ? horizontalOffset : null,
      right: !isLeft ? horizontalOffset : null,
      child: CustomTextButton(
        text: text,
        isSelected: controller.selectedButton.value == faceType.toLowerCase(),
        onTap: () {
          controller.changeFaceImage(faceType);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FaceController());
    final size = MediaQuery.of(context).size;
    final leftRight = size.width * 0.07;

    return Stack(
      children: [
        Center(
          child: Obx(
            () => Image.asset(
              controller.currentFaceImage.value,
              width: size.width * 0.7,
            ),
          ),
        ),
        Obx(
          () => Stack(
            children: [
              _buildPositionedButton(
                top: size.height * 0.37,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'down'.tr,
                faceType: 'down',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.45,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'cheeks'.tr,
                faceType: 'cheeks',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.5,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'neck'.tr,
                faceType: 'neck',
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
