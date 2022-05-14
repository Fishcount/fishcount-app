import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';

abstract class AbstractService extends CustomDio {
  Future<Response<dynamic>> post(String url, Map<String, dynamic> data) async {
    return await dioPost(url, data);
  }

  Future<Response<List<dynamic>>> getAll(String url) async {
    return await dioGetAll(url);
  }

  Future<void> put(String url, Map<String, dynamic> data) async {
    await dioPut(url, data);
  }
}
