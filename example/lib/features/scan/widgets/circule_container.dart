import 'package:flutter/material.dart';

import '../../../core/constants/app/app_assets.dart';
import '../../../core/constants/ui/app_colors.dart';
import '../../../core/constants/ui/app_text_styles.dart';

class CirculeContainer extends StatelessWidget {
  const CirculeContainer({
    required this.icon,
    required this.title,
    this.height,
    this.width,
    this.onTap,
    super.key,
    this.iconSize = 50,
  });
  final double? height;
  final double? iconSize;
  final double? width;
  final String icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? size.width * 0.55,
        width: width ?? size.width * 0.55,
        decoration: const BoxDecoration(
          color: AppColors.black,
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage(AppAssets.circleBg)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: iconSize),
            Text(title, style: AppTextStyles.body1),
          ],
        ),
      ),
    );
  }
}
