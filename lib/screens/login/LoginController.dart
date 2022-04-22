import 'package:dio/dio.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/screens/login/LoginService.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/custom/CustomSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  void doLogin(BuildContext context, String email, String senha) async {
    AuthUserModel userModel = AuthUserModel(email, senha);
    ConnectionUtils().isConnected().then((isConnected) {
      if (isConnected) {
        print("conectado");
        loginWithApi(userModel, context);
      } else {
        print("nao conectado");
        // consultar banco local
      }
    });
  }

  Future<dynamic> loginWithApi(
      AuthUserModel userModel, BuildContext context) async {
    dynamic response =
        await LoginService().doLogin(userModel.username, userModel.password);

    if (response is AuthUserModel) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LotesScreen()));
    }
    if (response is ErrorModel) {
      return CustomSnackBar.getCustomSnackBar(context, response.message!);
    }
  }

  void resolveToken(Response<dynamic> response, SharedPreferences prefs) {}
}
