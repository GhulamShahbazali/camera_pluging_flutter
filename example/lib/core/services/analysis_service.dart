import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../api/models/analysis_response.dart';


class AnalysisService {
  AnalysisService({Dio? dio}) : _dio = dio ?? ApiClient().dio;

  final Dio _dio;

  Future<AnalysisResponse> analyzeImage({required String imageDataUrl}) async {
    final response = await _dio.post(
      '${ApiEndpoints.analysisBaseUrl}${ApiEndpoints.analyze}',
      data: {'image': imageDataUrl},
      options: Options(
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 && response.data is Map) {
      return AnalysisResponse.fromJson(response.data as Map<String, dynamic>);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Unexpected response from server',
      type: DioExceptionType.badResponse,
    );
  }
}
