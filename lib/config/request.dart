import 'package:dio/dio.dart';

const BASE_URL = 'https://jsonplaceholder.typicode.com';

Dio crateDio() {
  BaseOptions options = BaseOptions(
      baseUrl: BASE_URL, connectTimeout: 5000, receiveTimeout: 3000);

  Dio dio = Dio(options);

  dio.interceptors.add(LogInterceptor(
      error: true,
      request: false,
      responseBody: true,
      responseHeader: false,
      requestHeader: false));

  return dio;
}
