import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyAreaController extends GetxController {
  late PageController pageController;
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  Future<void> onPageChanged(int index) async {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
