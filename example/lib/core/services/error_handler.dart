import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../constants/app/app_strings.dart';
import '../widgets/custom_snackbar.dart';


/// Simple and clean error handling service
class ErrorHandler {
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();
  static final ErrorHandler _instance = ErrorHandler._internal();

  /// Handle API errors and show appropriate messages
  void handleError(dynamic error) {
    debugPrint('❌ Error: $error');

    String message;
    var showGlobalNotification = false;

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          message = 'timeout_error';
          showGlobalNotification = true;
        case DioExceptionType.connectionError:
          message = 'network_error';
          showGlobalNotification = true;
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          switch (statusCode) {
            case 400:
              message = 'bad_request_error';
            case 401:
              message = 'forbidden_error';
            case 403:
              message = 'forbidden_error';
            case 404:
              message = 'not_found_error';
            case 422:
              message = 'validation_error';
            case 500:
            case 502:
            case 503:
            case 504:
              message = 'server_error';
              showGlobalNotification = true;
            default:
              message = 'unknown_error';
          }
        case DioExceptionType.cancel:
          message = 'request_cancelled';
        case DioExceptionType.badCertificate:
          message = 'certificate_error';
        case DioExceptionType.unknown:
          message = 'unknown_error';
      }
    } else {
      message = error.toString().isNotEmpty
          ? error.toString()
          : AppStrings.unknownError;
    }

    if (showGlobalNotification) {
      _showGlobalNotification(message);
    }
  }

  /// Show global error notification
  void _showGlobalNotification(String message) {
    showCustomSnackbar(
      title: '',
      message: message,
      type: SnackbarType.error,
      duration: const Duration(seconds: 4),
    );
  }

  /// Show success notification
  void showSuccess(String message) {
    showCustomSnackbar(title: '', message: message, type: SnackbarType.success);
  }

  /// Show info notification
  void showInfo(String message) {
    showCustomSnackbar(title: '', message: message);
  }
}
