import 'package:fishcount_app/api/Autenticacao.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';

class LoginController {
  String url = Autenticacao.loginDev;

  void doLogin(String email, String senha) {
    AuthUserModel userModel = AuthUserModel(email, senha);
    if (ConnectionUtils.isConnected()) {
    } else {
      // consultar banco local
    }
  }
}
