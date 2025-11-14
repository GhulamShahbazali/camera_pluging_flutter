// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../../core/constants/app/app_assets.dart';
// import '../../../core/widgets/background_container.dart';
// import '../../../core/widgets/setting_icon.dart';
// import '../../../core/widgets/ultrascan4d.dart';
// import '../controllers/scan_controller.dart';
// import '../widgets/circule_container.dart';
//
// class ScanPage extends StatelessWidget {
//   const ScanPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ScanController());
//     final size = MediaQuery.sizeOf(context);
//
//     return Obx(
//       () => Scaffold(
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         body: Stack(
//           children: [
//             BackgroundContainer(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 80),
//                   const Align(
//                     alignment: Alignment.topRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 18),
//                       child: SettingIconWidget(),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Ultrascan4d(),
//                   if (controller.selectedImage.value == null) ...[
//                     const Spacer(),
//                     CirculeContainer(
//                       icon: AppAssets.cameraIcon,
//                       title: 'start_scan'.tr,
//                       onTap: controller.pickImage,
//                     ),
//                     const Spacer(),
//                     const Spacer(),
//                   ] else
//                     SizedBox(
//                       height: size.height * 0.725,
//                       width: size.width,
//                       // color: Colors.white,
//                       child: Image.file(
//                         File(controller.selectedImage.value!.path),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//             if (controller.isLoading.value)
//               ColoredBox(
//                 color: Colors.black.withValues(alpha: 0.45),
//                 child: const Center(
//                   child: CircularProgressIndicator(color: Colors.white),
//                 ),
//               ),
//           ],
//         ),
//         floatingActionButton: controller.selectedImage.value == null
//             ? null
//             : CirculeContainer(
//                 height: size.width * 0.35,
//                 width: size.width * 0.35,
//                 icon: AppAssets.scanIcon,
//                 title: 'analyze_with_ai'.tr,
//                 onTap: controller.isLoading.value
//                     ? null
//                     : controller.analyzeSelectedImage,
//               ),
//       ),
//     );
//   }
// }


import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';


import '../../../core/constants/app/app_assets.dart';
import '../../../core/widgets/background_container.dart';
import '../../../core/widgets/setting_icon.dart';
import '../../../core/widgets/ultrascan4d.dart';
import '../controllers/scan_controller.dart';
import '../widgets/circule_container.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScanController());
    final size = MediaQuery.sizeOf(context);

    return Obx(
          () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            BackgroundContainer(
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: SettingIconWidget(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Ultrascan4d(),
                  if (controller.selectedImage.value == null) ...[
                    const Spacer(),
                    CirculeContainer(
                      icon: AppAssets.cameraIcon,
                      title: 'start_scan'.tr,
                      onTap: controller.pickImage,
                    ),
                    const Spacer(),
                    const Spacer(),
                  ] else
                    SizedBox(
                      height: size.height * 0.725,
                      width: size.width,
                      // color: Colors.white,
                      child: Image.file(
                        File(controller.selectedImage.value!.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            if (controller.isLoading.value)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.45),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
        floatingActionButton: controller.selectedImage.value == null
            ? null
            : CirculeContainer(
          height: size.width * 0.35,
          width: size.width * 0.35,
          icon: AppAssets.scanIcon,
          title: 'analyze_with_ai'.tr,
          onTap: controller.isLoading.value
              ? null
              : controller.analyzeSelectedImage,
        ),
      ),
    );
  }
}


