import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/api/Autenticacao.dart';
import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  String url = Autenticacao.loginDev;

  dynamic doLogin(String email, String senha) async {
    try {
      AuthUserModel userModel = AuthUserModel(email, senha);
      Response<dynamic> response =
          await CustomDio().post(url, userModel.toJson());

      if (response.statusCode == 200) {
        AuthUserModel authUser = AuthUserModel.fromJson(response.data);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", authUser.token);
        prefs.setInt("userId", authUser.id);
        prefs.setString("userEmail", authUser.username);

        return authUser;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        return ErrorModel.fromJson(e.response!.data).toJson();
      }
      return ErrorModel(ExceptionsMessage.serverError, null, null, null);
    }
  }
}
