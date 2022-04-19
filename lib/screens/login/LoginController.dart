import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/screens/login/LoginService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
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
    dynamic responseLogin =
        await LoginService().doLogin(userModel.username, userModel.password);

    if (responseLogin is AuthUserModel) {
      Navigator.pushReplacementNamed(context, AppPaths.lotesPath);
    }
    if (responseLogin is ErrorModel) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseLogin.message!),
          backgroundColor: Colors.red[400],
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: "",
            onPressed: () {},
          ),
        ),
      );
    }
  }

  void resolveToken(Response<dynamic> response, SharedPreferences prefs) {}
}
