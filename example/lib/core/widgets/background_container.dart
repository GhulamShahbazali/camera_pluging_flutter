import 'package:flutter/material.dart';

import '../constants/app/app_assets.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
