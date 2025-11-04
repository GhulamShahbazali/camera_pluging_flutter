import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usb_camera_plugin_example/core/constants/index.dart';
import 'package:usb_camera_plugin_example/core/widgets/background_container.dart';
import 'package:usb_camera_plugin_example/features/scan/controllers/scan_controller.dart';

class CapturedImageScreen extends StatefulWidget {
  final String imagePath;

  const CapturedImageScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<CapturedImageScreen> createState() => _CapturedImageScreenState();
}

class _CapturedImageScreenState extends State<CapturedImageScreen> {
  late ScanController logic;

  @override
  void initState() {
    super.initState();

    logic = Get.find<ScanController>();
    onInit();
  }

  void onInit() {
    logic.selectedImage.value=  File(widget.imagePath);
    logic.analyzeSelectedImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BackgroundContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.gold300Color),
            ],
          ),
        ),
      ),
    );
  }
}
