import 'dart:io';

import 'package:dio/dio.dart';

class DioManager {
  final _dio = Dio();

  DioManager() {
    _dio
      ..httpClientAdapter
      ..options.headers = {
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  final String baseUrl = 'https://logatta_task-1-h6266999.deta.app/';

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.get(
      '$baseUrl$uri',
      queryParameters: queryParameters,
    );
    return response;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
