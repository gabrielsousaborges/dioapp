import 'package:dio/dio.dart';
import 'package:dioapp/repository/back4app/back4app_dio_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Back4AppCustonDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustonDio() {
    _dio.options.headers["Content-Type"] = "";

    _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}