import 'package:get/get.dart';
import 'package:flutter/material.dart';


import '../../routes/app_pages.dart';
import '../constants/app/app_assets.dart';
import '../constants/ui/app_colors.dart';

class SettingIconWidget extends StatelessWidget {
  const SettingIconWidget({super.key, this.onTap, this.haveArrowIcon = false});
  final VoidCallback? onTap;
  final bool haveArrowIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          onTap ??
          () {
            Get.toNamed(AppPages.settingPage);
          },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.goldColor),
        ),
        child: haveArrowIcon
            ? const Icon(Icons.arrow_back, color: AppColors.white)
            : Image.asset(AppAssets.settingIcon, height: 25),
      ),
    );
  }
}
