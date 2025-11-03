import 'package:flutter/material.dart';

import '../../constants/ui/app_colors.dart';
import '../../constants/ui/app_sizes.dart';
import '../../constants/ui/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? AppSizes.buttonHeightMd,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          elevation: AppSizes.cardElevation,
        ),
        child: isLoading
            ? const SizedBox(
                width: AppSizes.iconSm,
                height: AppSizes.iconSm,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.progressIndicatorSize,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(text, style: AppTextStyles.heading1),
      ),
    );
  }
}
