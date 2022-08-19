import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';

abstract class AbstractService extends CustomDio {
  Future<Response<dynamic>> post(String url, Map<String, dynamic> data) async {
    return await dioPost(url, data);
  }

  Future<Response<List<dynamic>>> getAll(String url) async {
    return await dioGetAll(url);
  }

  Future<Response<dynamic>> get(String url) async {
    return await dioGet(url);
  }

  Future<Response<void>> put(String url, Map<String, dynamic> data) async {
    return await dioPut(url, data);
  }

  Future<Response<void>> delete(String url) async {
    return await dioDelete(url);
  }
}
