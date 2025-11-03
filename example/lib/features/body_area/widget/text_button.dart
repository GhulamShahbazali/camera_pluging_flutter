import 'package:flutter/material.dart';

import '../../../core/constants/ui/app_colors.dart';
import '../../../core/constants/ui/app_text_styles.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.onTap,
    super.key,
    this.paddingVertical,
    this.paddingHorizontal,
    this.isSelected = false,
    this.color = AppColors.yellowColor,
  });

  final double? paddingHorizontal;
  final double? paddingVertical;
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(7),
        child: Container(
          decoration: BoxDecoration(
            gradient: isSelected
                ? null
                : const LinearGradient(
                    colors: [
                      AppColors.gold600Color,
                      AppColors.goldColor,
                      AppColors.goldColor,
                    ],
                  ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isSelected ? color : AppColors.blackColor,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? 17,
              vertical: paddingVertical ?? 8,
            ),
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.body1.copyWith(
                  color: isSelected
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
