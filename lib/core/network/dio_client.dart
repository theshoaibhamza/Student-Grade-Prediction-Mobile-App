import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: Duration(milliseconds: AppConstants.connectionTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print(
            'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
