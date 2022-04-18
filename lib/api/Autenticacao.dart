import 'package:fishcount_app/api/Environment.dart';

class Autenticacao {
  static const String _url = "/login";

  static const String loginDev = Environment.localDev + _url;
  static const String loginProd = Environment.localProd + _url;
}
