import 'package:dio/dio.dart';

class JsonPlaceHolderDIO {
  final _dio = Dio();

  Dio get dio => _dio;
  JsonPlaceHolderDIO() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}
