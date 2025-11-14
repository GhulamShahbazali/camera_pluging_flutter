import 'dart:developer';

import 'package:dio/dio.dart';

import '../api/api_endpoints.dart';


class UltrascanResultService {
  UltrascanResultService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<Response<dynamic>> submitResult({
    required String macAddress,
    required int piel,
    required int color,
    required num thick,
    required String zone,
  }) async {
    final url =
        '${ApiEndpoints.deviceActivationBaseUrl}/UltraScan.php'
        '?MAC_Address=$macAddress'
        '&Piel=$piel'
        '&Color=$color'
        '&Thick=$thick'
        '&Zone=$zone';

    log(url);
    return _dio.get(
      url,
      options: Options(
        headers: const {'Accept': 'application/json, text/plain, */*'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }
}
