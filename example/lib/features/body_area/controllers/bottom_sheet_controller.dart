import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/ultrascan_api_service.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../chat_screen/chat_screen.dart';

class BottomSheetController extends GetxController {
  final TextEditingController questionController = TextEditingController();
  final UltraScanApiService apiService = UltraScanApiService();
  final RxBool isLoading = false.obs;
  final RxString selectedQuestion = ''.obs;

  /// Set the selected question and fill the text field
  void selectQuestion(String question) {
    if (isLoading.value) return;
    selectedQuestion.value = question;
    questionController.text = question;
  }

  /// Handle sending the question
  Future<void> sendQuestion() async {
    final question = questionController.text.trim();
    if (question.isEmpty || isLoading.value) return;

    isLoading.value = true;

    // Get MAC address from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final macAddress = prefs.getString('saved_mac_address');

    if (macAddress == null || macAddress.isEmpty) {
      isLoading.value = false;
      showCustomSnackbar(
        title: '',
        message: 'Please configure MAC address in settings',
        type: SnackbarType.error,
      );
      return;
    }

    try {
      // Call UltraScan API to get Gemini API key
      final apiResponse = await apiService.getApiKey(macAddress: macAddress);

      // Close bottom sheet first
      Get.back(); // Close bottom sheet

      // Small delay to ensure bottom sheet animation completes before navigation
      await Future.delayed(const Duration(milliseconds: 200));

      // Navigate to ChatScreen
      Get.to(
        () => ChatScreen(
          initialQuestion: question,
          geminiApiKey: apiResponse.apiKey,
          systemInstruction: apiResponse.systemInstruction,
          dataContext: apiResponse.dataContext,
        ),
      );
    } on DioException catch (e) {
      String errorMessage = 'Failed to get API access. Please try again.';
      if (e.response?.data != null) {
        if (e.response!.data is Map) {
          errorMessage = e.response!.data['message'] ?? errorMessage;
        } else if (e.response!.data is String) {
          errorMessage = e.response!.data;
        }
      } else if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = e.message!;
      }
      showCustomSnackbar(
        title: '',
        message: errorMessage,
        type: SnackbarType.error,
      );
    } catch (e) {
      showCustomSnackbar(
        title: '',
        message: 'An error occurred. Please try again.',
        type: SnackbarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    questionController.dispose();
    super.onClose();
  }
}
