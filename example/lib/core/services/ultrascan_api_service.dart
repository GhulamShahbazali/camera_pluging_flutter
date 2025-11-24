import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api/api_endpoints.dart';

class UltraScanApiResponse {
  final String apiName;
  final String apiKey;
  final String projectNumber;
  final int rateLimit;

  UltraScanApiResponse({
    required this.apiName,
    required this.apiKey,
    required this.projectNumber,
    required this.rateLimit,
  });

  factory UltraScanApiResponse.fromJson(Map<String, dynamic> json) {
    return UltraScanApiResponse(
      apiName: json['API_NAME'] ?? '',
      apiKey: json['API_KEY'] ?? '',
      projectNumber: json['PROJECT_NUMBER'] ?? '',
      rateLimit: json['RATE_LIMIT'] ?? 0,
    );
  }
}

class UltraScanApiService {
  UltraScanApiService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Fetch Gemini API key from UltraScan API endpoint
  /// Returns [UltraScanApiResponse] if successful and rate limit > 0
  /// Throws DioException on failure
  Future<UltraScanApiResponse> getApiKey({required String macAddress}) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.ultraScanApiBaseUrl}${ApiEndpoints.ultraScanApi(macAddress: macAddress)}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (kDebugMode) {
        debugPrint('🔗 UltraScan API Response: ${response.statusCode}');
        debugPrint('📥 Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        final dynamic data = response.data;

        // Handle JSON response - Dio should parse JSON automatically
        Map<String, dynamic> jsonData;
        if (data is Map) {
          jsonData = Map<String, dynamic>.from(data);
        } else if (data is String) {
          // Try to parse JSON string manually
          try {
            jsonData = jsonDecode(data) as Map<String, dynamic>;
          } catch (e) {
            // If parsing fails, try to extract JSON manually
            try {
              final jsonMatch = RegExp(r'\{[^}]+\}').firstMatch(data);
              if (jsonMatch != null) {
                jsonData = jsonDecode(jsonMatch.group(0) ?? '{}')
                    as Map<String, dynamic>;
              } else {
                throw DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: 'Failed to parse response: $data',
                  type: DioExceptionType.badResponse,
                );
              }
            } catch (parseError) {
              throw DioException(
                requestOptions: response.requestOptions,
                response: response,
                message: 'Failed to parse response: $data',
                type: DioExceptionType.badResponse,
              );
            }
          }
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: 'Unexpected response format',
            type: DioExceptionType.badResponse,
          );
        }

        final apiResponse = UltraScanApiResponse.fromJson(jsonData);

        // Check if rate limit is greater than 0
        if (apiResponse.rateLimit <= 0) {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: 'Rate limit exceeded or invalid',
            type: DioExceptionType.badResponse,
          );
        }

        return apiResponse;
      }

      // Non-200 (<500 due to validateStatus) treated as bad response
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'UltraScan API failed with status ${response.statusCode}',
        type: DioExceptionType.badResponse,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ UltraScan API Error: $e');
      }
      if (e is DioException) {
        rethrow;
      }
      throw DioException(
        requestOptions: RequestOptions(),
        message: e.toString(),
      );
    }
  }
}

