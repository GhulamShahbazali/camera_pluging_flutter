import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/app/app_strings.dart';
import '../services/error_handler.dart';


/// Base controller with common functionality for all controllers
abstract class BaseController extends GetxController {
  // Loading state
  final RxBool isLoading = false.obs;

  // Error handling
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  // Success state
  final RxString successMessage = ''.obs;
  final RxBool hasSuccess = false.obs;

  // Services
  final ErrorHandler _errorHandler = ErrorHandler();

  /// Show loading state
  void showLoading() {
    isLoading.value = true;
    clearMessages();
  }

  /// Hide loading state
  void hideLoading() {
    isLoading.value = false;
  }

  /// Show error message
  void showError(String message) {
    errorMessage.value = message;
    hasError.value = true;
    hideLoading();
  }

  /// Show success message
  void showSuccess(String message) {
    successMessage.value = message;
    hasSuccess.value = true;
    hideLoading();
  }

  /// Clear all messages
  void clearMessages() {
    errorMessage.value = '';
    hasError.value = false;
    successMessage.value = '';
    hasSuccess.value = false;
  }

  /// Handle API errors
  void handleApiError(dynamic error) {
    _errorHandler.handleError(error);
    errorMessage.value = _getErrorMessage(error);
    hasError.value = true;
    hideLoading();
  }

  /// Handle API errors with custom message
  void handleApiErrorWithMessage(String message) {
    errorMessage.value = message;
    hasError.value = true;
    hideLoading();
  }

  /// Safe API call wrapper
  Future<T?> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      showLoading();
      final result = await apiCall();
      hideLoading();
      return result;
    } catch (error) {
      handleApiError(error);
      return null;
    }
  }

  /// Get user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppStrings.timeoutError;
        case DioExceptionType.connectionError:
          return AppStrings.networkError;
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          switch (statusCode) {
            case 400:
              return AppStrings.badRequestError;
            case 401:
              return AppStrings.forbiddenError;
            case 403:
              return AppStrings.forbiddenError;
            case 404:
              return AppStrings.notFoundError;
            case 422:
              return AppStrings.validationError;
            case 500:
            case 502:
            case 503:
            case 504:
              return AppStrings.serverError;
            default:
              return AppStrings.unknownError;
          }
        case DioExceptionType.cancel:
          return AppStrings.requestCancelled;
        case DioExceptionType.badCertificate:
          return AppStrings.certificateError;
        case DioExceptionType.unknown:
          return AppStrings.unknownError;
      }
    }
    return error.toString().isNotEmpty
        ? error.toString()
        : AppStrings.unknownError;
  }

  @override
  void onClose() {
    clearMessages();
    super.onClose();
  }
}
