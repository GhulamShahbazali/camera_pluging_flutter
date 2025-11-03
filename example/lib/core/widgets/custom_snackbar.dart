import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/ui/app_colors.dart';

enum SnackbarType { info, success, error, warning }

void showCustomSnackbar({
  required String title,
  required String message,
  SnackbarType type = SnackbarType.info,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  Color background;
  IconData inferredIcon;
  String defaultTitleKey;

  switch (type) {
    case SnackbarType.success:
      background = AppColors.success;
      inferredIcon = Icons.check_circle;
      defaultTitleKey = 'success';
    case SnackbarType.error:
      background = AppColors.error;
      inferredIcon = Icons.error;
      defaultTitleKey = 'error';
    case SnackbarType.warning:
      background = AppColors.warning;
      inferredIcon = Icons.warning_amber_rounded;
      defaultTitleKey = 'warning';
    case SnackbarType.info:
      background = AppColors.info;
      inferredIcon = Icons.info;
      defaultTitleKey = 'info';
  }

  final localizedTitle = (title.isEmpty ? defaultTitleKey : title).tr;
  final localizedMessage = message.tr;

  Get.snackbar(
    localizedTitle,
    localizedMessage,
    colorText: AppColors.white,
    backgroundColor: background.withValues(alpha: 0.95),
    icon: Icon(icon ?? inferredIcon, color: AppColors.white),
    snackPosition: SnackPosition.BOTTOM,
    duration: duration,
    margin: const EdgeInsets.all(16),
    borderRadius: 8,
  );
}
