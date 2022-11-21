import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        SharedPreferences prefs = await SharedPreferencesUtils.addSharedPreferences(authUser);

        assert(prefs.getString(EnumSharedPreferences.userEmail.name) == email);

        return authUser;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
