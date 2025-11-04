import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usb_camera_plugin_example/core/constants/index.dart';
import 'package:usb_camera_plugin_example/core/widgets/background_container.dart';
import 'package:usb_camera_plugin_example/features/scan/controllers/scan_controller.dart';

class CapturedImageScreen extends StatelessWidget {
  final String imagePath;

  const CapturedImageScreen({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Call analysis AFTER frame builds (avoids setState/Obx conflict)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<ScanController>();
      controller.selectedImage.value = File(imagePath);
      controller.analyzeSelectedImage();
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.gold300Color),
              const SizedBox(height: 16),
              const Text(
                'Analyzing image...',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}