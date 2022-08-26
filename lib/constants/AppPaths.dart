
import 'package:flutter/cupertino.dart';

import '../modules/batch/BatchForm.dart';
import '../modules/batch/BatchScreen.dart';
import '../modules/login/LoginScreen.dart';
import '../modules/person/PessoaDataForm.dart';
import '../modules/person/PessoaForm.dart';

class AppPaths {
  static const String loginPath = '/login';
  static const String lotesPath = '/lotes';
  static const String usuarioPath = '/usuario';
  static const String cadastroUsuarioPath = '/cadastro_user';
  static const String cadastroLotePath = '/cadastro_lote';


  static const Map<String, Widget> paths = {
    loginPath: LoginScreen(),
    lotesPath: BatchScreen(),
    usuarioPath: PessoaDataForm(),
    cadastroUsuarioPath: PessoaForm(),
    cadastroLotePath: BatchForm(),

  };
}
