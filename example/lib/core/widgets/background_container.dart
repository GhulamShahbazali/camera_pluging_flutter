import 'package:flutter/material.dart';
import '../constants/app/app_assets.dart';
import 'package:usb_camera_plugin_example/core/constants/ui/app_colors.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({
    required this.child,
    this.isImage = true,
    super.key,
  });
  final Widget child;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    debugPrint("isImage: ${isImage.toString()}");
    // Always provide BoxDecoration to avoid caching issues when switching between states
    return Container(
      key: ValueKey(isImage),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.black,
        image: isImage
            ? const DecorationImage(
                image: AssetImage(AppAssets.bg),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
