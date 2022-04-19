import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomInterceptors.dart';
import 'package:fishcount_app/constants/api/Environment.dart';

class CustomDio {
  CustomDio() {
    Dio customDio = Dio();
    customDio.options.baseUrl = Environment.localDev;
    customDio.interceptors.add(CustomInterceptors());
    dio = customDio;
  }

  late Dio dio = Dio();

  Future<Response<dynamic>> post(String url, Map<String, dynamic> data) async {
    return await dio.post(url, data: data);
  }

  Future<Response<List<dynamic>>> getAll(String url) async {
    return await dio.get(url);
  }
}
