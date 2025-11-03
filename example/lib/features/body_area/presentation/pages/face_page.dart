import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/frontal_controller.dart';
import '../../widget/text_button.dart';


class FrontalPage extends StatelessWidget {
  const FrontalPage({super.key});

  Widget _buildPositionedButton({
    required double top,
    required double horizontalOffset,
    required bool isLeft,
    required String text,
    required String bodyPart,
    required FrontalController controller,
  }) {
    return Positioned(
      top: top,
      left: isLeft ? horizontalOffset : null,
      right: !isLeft ? horizontalOffset : null,
      child: CustomTextButton(
        text: text,
        isSelected: controller.selectedButton.value == bodyPart.toLowerCase(),
        onTap: () {
          controller.changeFrontalImage(bodyPart);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrontalController());
    final size = MediaQuery.of(context).size;
    final leftRight = size.width * 0.05;

    return Stack(
      children: [
        Center(
          child: Obx(
            () => Image.asset(
              controller.currentFrontalImage.value,
              width: size.width * 0.7,
            ),
          ),
        ),
        Obx(
          () => Stack(
            children: [
              // Left side buttons
              _buildPositionedButton(
                top: size.height * 0.27,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'peco'.tr,
                bodyPart: 'peco',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.35,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'armpits'.tr,
                bodyPart: 'armpits',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.6,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'bikini'.tr,
                bodyPart: 'bikini',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.75,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'lower_leg'.tr,
                bodyPart: 'lowerleg',
                controller: controller,
              ),
              // Right side buttons
              _buildPositionedButton(
                top: size.height * 0.27,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'arms'.tr,
                bodyPart: 'arms',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.35,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'abdomen'.tr,
                bodyPart: 'abdomen',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.6,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'thighs'.tr,
                bodyPart: 'thighs',
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
