import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:usb_camera_plugin_example/core/constants/ui/app_colors.dart';
import 'package:usb_camera_plugin_example/core/constants/app/app_assets.dart';
import 'package:usb_camera_plugin_example/core/constants/ui/app_text_styles.dart';

class SendTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSend;
  final bool enabled;
  final bool isLoading;
  const SendTextField({
    super.key,
    required this.controller,
    this.onSend,
    this.enabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.sendTextFeildBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gold600Color,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gold400Color, width: 1),
                ),
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'write_question_here'.tr,
                    hintStyle: AppTextStyles.body2.copyWith(
                      color: AppColors.gold400Color,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: (enabled && !isLoading)
                  ? () {
                      if (controller.text.isNotEmpty) {
                        onSend?.call();
                        controller.clear();
                      }
                    }
                  : null,
              child: Opacity(
                opacity: (enabled && !isLoading) ? 1.0 : 0.5,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.yellowColor,
                              ),
                            ),
                          ),
                        )
                      : Image.asset(AppAssets.sendIcon, width: 50, height: 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
