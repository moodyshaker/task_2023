import 'package:dio/dio.dart';


const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioManager {
  final _dio =
  Dio(BaseOptions(baseUrl: 'https://logatta_task-1-h6266999.deta.app/'));

  DioManager() {
    _dio
    ..httpClientAdapter
    ..options.headers = {
    'Accept-Language': 'ar',
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    };
  }

  Future<Response> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
      }) async {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
      );
      return response;
  }
}
