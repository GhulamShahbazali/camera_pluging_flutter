import 'package:flutter/material.dart';

import '../constants/app/app_strings.dart';
import '../constants/ui/app_colors.dart';
import '../constants/ui/app_sizes.dart';
import '../constants/ui/app_text_styles.dart';

/// Simple error display widget
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
    this.showRetryButton = true,
  });

  final String message;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: AppSizes.iconMd,
              ),
              const SizedBox(width: AppSizes.spacingSm),
              Expanded(
                child: Text(
                  AppStrings.error,
                  style: AppTextStyles.title1.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingXs),
          Text(
            message,
            style: AppTextStyles.title1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (showRetryButton && onRetry != null) ...[
            const SizedBox(height: AppSizes.spacingSm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRetry,
                child: Text(
                  AppStrings.retry,
                  style: AppTextStyles.title1.copyWith(color: AppColors.error),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Compact error display for inline use
class CompactErrorWidget extends StatelessWidget {
  const CompactErrorWidget({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: AppSizes.iconSm,
          ),
          const SizedBox(width: AppSizes.spacingXs),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.title1.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty state error display
class EmptyStateErrorWidget extends StatelessWidget {
  const EmptyStateErrorWidget({
    required this.message,
    super.key,
    this.onRetry,
    this.title = AppStrings.somethingWentWrong,
  });

  final String message;
  final VoidCallback? onRetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppSizes.iconXl,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSizes.spacingMd),
            Text(
              title,
              style: AppTextStyles.heading3.copyWith(
                color: AppColors.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spacingSm),
            Text(
              message,
              style: AppTextStyles.title1.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSizes.spacingLg),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text(AppStrings.tryAgain),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
