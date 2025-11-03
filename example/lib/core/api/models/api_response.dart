
import '../../constants/app/api_constants.dart';

class ApiResponse<T> {
  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.error,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error({
    required String message,
    int? statusCode,
    dynamic error,
  }) {
    return ApiResponse<T>(
      success: false,
      message: message,
      statusCode: statusCode,
      error: error,
    );
  }

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final success = (json[ApiConstants.success] as bool?) ??
          (json[ApiConstants.status] as String?) == ApiConstants.statusSuccess;
      final message = json[ApiConstants.message] as String?;
      final statusCode = json[ApiConstants.statusCode] as int?;

      if (success == true) {
        final dataJson = json[ApiConstants.data] as Map<String, dynamic>?;
        final data = dataJson != null ? fromJson(dataJson) : null;
        return ApiResponse.success(
          data: data,
          message: message,
          statusCode: statusCode,
        );
      } else {
        return ApiResponse.error(
          message: message ?? ApiConstants.unknownError,
          statusCode: statusCode,
          error: json[ApiConstants.error],
        );
      }
    } catch (e) {
      return ApiResponse.error(
        message: '${ApiConstants.parseError}: $e',
        error: e,
      );
    }
  }
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  final dynamic error;

  @override
  String toString() {
    return 'ApiResponse{success: $success, data: $data, message: $message, statusCode: $statusCode, error: $error}';
  }
}
