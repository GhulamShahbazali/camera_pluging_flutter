import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


import '../constants/app/api_constants.dart';
import '../services/error_handler.dart';
import 'api_endpoints.dart';

class ApiClient {
  factory ApiClient() => _instance;
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();

  late Dio _dio;
  final ErrorHandler _errorHandler = ErrorHandler();

  Dio get dio => _dio;

  Future<void> initialize() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          ApiConstants.contentType: ApiConstants.applicationJson,
          ApiConstants.accept: ApiConstants.applicationJson,
        },
      ),
    );

    // Add interceptors
    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Request interceptor for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Log request
          debugPrint('🌐 API Request: ${options.method} ${options.path}');
          debugPrint('📤 Request Data: ${options.data}');

          handler.next(options);
        },
      ),
    );

    // Response interceptor for logging and data transformation
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          debugPrint('✅ API Response: ${response.statusCode}');
          debugPrint('📥 Response Data: ${response.data}');

          handler.next(response);
        },
      ),
    );

    // Error interceptor for handling common errors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          debugPrint('❌ API Error: ${error.message}');
          debugPrint('🔍 Error Details: ${error.response?.data}');

          // Handle errors
          _errorHandler.handleError(error);

          handler.next(error);
        },
      ),
    );
  }
}
