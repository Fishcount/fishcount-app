import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/Autenticacao.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../../utils/RequestBuilder.dart';

class LoginService extends AbstractService {
  
  dynamic doLogin(String email, String senha) async {
    try {
      AuthUserModel userModel = AuthUserModel(email, senha);
      Response<dynamic> response = await RequestBuilder(url: '/login')
          .setBody(userModel.toJson())
          .post();

      if (response.statusCode == 200) {
        AuthUserModel authUser = AuthUserModel.fromJson(response.data);
        SharedPreferencesUtils.addSharedPreferences(authUser);
        return authUser;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
