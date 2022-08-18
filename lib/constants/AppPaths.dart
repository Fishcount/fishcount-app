
import 'package:flutter/cupertino.dart';

import '../modules/login/LoginScreen.dart';
import '../modules/lote/LoteForm.dart';
import '../modules/lote/LotesScreen.dart';
import '../modules/usuario/PessoaDataForm.dart';
import '../modules/usuario/PessoaForm.dart';

class AppPaths {
  static const String loginPath = '/login';
  static const String lotesPath = '/lotes';
  static const String usuarioPath = '/usuario';
  static const String cadastroUsuarioPath = '/cadastro_user';
  static const String cadastroLotePath = '/cadastro_lote';


  static const Map<String, Widget> paths = {
    loginPath: LoginScreen(),
    lotesPath: LotesScreen(),
    usuarioPath: PessoaDataForm(),
    cadastroUsuarioPath: PessoaForm(),
    cadastroLotePath: LoteForm(),

  };
}
