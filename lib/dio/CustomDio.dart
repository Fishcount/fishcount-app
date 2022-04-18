import 'package:dio/dio.dart';
import 'package:fishcount_app/api/Environment.dart';

class CustomDio {
  Dio dio = Dio();

  CustomDio() {
    dio.options.baseUrl = Environment.localDev;
  }
}
