import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> addSharedPreferences(AuthUserModel auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", auth.token);
    prefs.setInt("userId", auth.id);
    prefs.setString("userEmail", auth.username);
  }

  Future<SharedPreferences> getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }

  ErrorModel verifyDioError(DioError error) {
    if (error.response != null) {
      return ErrorModel.fromJson(error.response!.data);
    }
    return ErrorModel(ExceptionsMessage.serverError, null, null, null);
  }
}
