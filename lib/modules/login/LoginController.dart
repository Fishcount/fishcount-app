import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:flutter/material.dart';

import 'LoginService.dart';

class LoginController {
  Future<dynamic> doLogin(BuildContext context, String email,
      String senha) async {
    AuthUserModel userModel = AuthUserModel(email, senha);

    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      dynamic result = await loginWithApi(userModel, context);
      return result;
    }
    dynamic result = loginLocal(context, email, senha);
    return result;
  }

  dynamic loginLocal(BuildContext context, String email, String senha) {
    return UsuarioRepository().login(context, email, senha);
  }

  Future<dynamic> loginWithApi(AuthUserModel userModel,
      BuildContext context) async {
    dynamic response =
    await LoginService().doLogin(userModel.username, userModel.password);

    if (response is AuthUserModel) {
      return true;
    }
    if (response is ErrorModel) {
      return ErrorHandler.getSnackBarError(context, response.message);
    }
  }
}