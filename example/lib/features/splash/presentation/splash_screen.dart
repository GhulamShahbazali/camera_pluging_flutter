import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app/app_assets.dart';
import '../../../core/constants/ui/app_text_styles.dart';
import '../../../routes/app_pages.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(AppPages.bodyAreaHome);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset(AppAssets.banner),
            const SizedBox(height: 20),
            Image.asset(AppAssets.ultraScanMachine, height: 520),
            const SizedBox(height: 20),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.initializingBanner),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('initializing'.tr, style: AppTextStyles.title1),
                  Text('loading_dots'.tr, style: AppTextStyles.title1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
