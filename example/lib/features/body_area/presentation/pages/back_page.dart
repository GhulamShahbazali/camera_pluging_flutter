import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:usb_camera_plugin_example/features/body_area/controllers/back_controller.dart';

import '../../widget/text_button.dart';

class BackPage extends StatelessWidget {
  const BackPage({super.key});

  Widget _buildPositionedButton({
    required double top,
    required double horizontalOffset,
    required bool isLeft,
    required String text,
    required String dorsal,
    required BackController controller,
  }) {
    return Positioned(
      top: top,
      left: isLeft ? horizontalOffset : null,
      right: !isLeft ? horizontalOffset : null,
      child: CustomTextButton(
        text: text,
        isSelected: controller.selectedButton.value == dorsal.toLowerCase(),
        onTap: () {
          controller.changeBackImage(dorsal);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BackController());
    final size = MediaQuery.of(context).size;
    final leftRight = size.width * 0.07;

    return Stack(
      children: [
        Center(
          child: Obx(
            () => Image.asset(
              controller.currentBackImage.value,
              width: size.width * 0.7,
            ),
          ),
        ),
        Obx(
          () => Stack(
            children: [
              _buildPositionedButton(
                top: size.height * 0.27,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'neck'.tr,
                dorsal: 'neck',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.6,
                horizontalOffset: leftRight,
                isLeft: true,
                text: 'back'.tr,
                dorsal: 'back',
                controller: controller,
              ),
              //right
              _buildPositionedButton(
                top: size.height * 0.27,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'shoulders'.tr,
                dorsal: 'shoulders',
                controller: controller,
              ),
              _buildPositionedButton(
                top: size.height * 0.6,
                horizontalOffset: leftRight,
                isLeft: false,
                text: 'glutes'.tr,
                dorsal: 'glutes',
                controller: controller,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
