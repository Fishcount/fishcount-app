import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/Autenticacao.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/screens/AbstractService.dart';

class LoginService extends AbstractService {
  String url = Autenticacao.loginDev;

  dynamic doLogin(String email, String senha) async {
    try {
      AuthUserModel userModel = AuthUserModel(email, senha);
      Response<dynamic> response = await post(url, userModel.toJson());

      if (response.statusCode == Responses.OK_STATUS_CODE) {
        AuthUserModel authUser = AuthUserModel.fromJson(response.data);
        addSharedPreferences(authUser);
        return authUser;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return verifyDioError(e);
    }
  }
}
