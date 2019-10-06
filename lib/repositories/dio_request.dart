import 'package:dio/dio.dart';

Dio dioClient() {
  BaseOptions options = BaseOptions(connectTimeout: 5000, receiveTimeout: 3000);

  Dio dio = Dio(options);

  dio.interceptors.add(LogInterceptor(
      error: true,
      request: false,
      responseBody: true,
      responseHeader: false,
      requestHeader: false));

  return dio;
}
