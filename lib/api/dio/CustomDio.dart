import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomInterceptors.dart';
import 'package:fishcount_app/constants/api/Environment.dart';

class CustomDio<T> {
  CustomDio() {
    Dio customDio = Dio();
    customDio.options.baseUrl = Environment.urlServer;
    customDio.interceptors.add(CustomInterceptors());
    customDio.options.connectTimeout = 10000;
    customDio.options.receiveDataWhenStatusError = true;
    dio = customDio;
  }

  late Dio dio = Dio();

  Future<Response<dynamic>> dioPost(
      String url, Map<String, dynamic> data) async {
    return await dio.post(url, data: data);
  }

  Future<Response<dynamic>> dioPostWithoutBody(String url) async {
    return await dio.post(url);
  }

  Future<Response<List<dynamic>>> dioGetAll(String url) async {
    return await dio.get(url);
  }

  Future<Response<dynamic>> dioGet(String url) async {
    return await dio.get(url);
  }

  Future<Response<dynamic>> dioPutWithoutBody(String url) async {
    return await dio.put(url);
  }

  Future<Response<void>> dioPut(String url, Map<String, dynamic> data) async {
    return await dio.put(url, data: data);
  }

  Future<Response<void>> dioDelete(String url) async {
    return await dio.delete(url);
  }
}
