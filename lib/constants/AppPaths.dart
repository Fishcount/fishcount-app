import 'package:fishcount_app/screens/login/LoginScreen.dart';
import 'package:fishcount_app/screens/lote/LoteForm.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/screens/tanque/TanqueForm.dart';
import 'package:fishcount_app/screens/tanque/TanqueScreen.dart';
import 'package:fishcount_app/screens/usuario/PessoaDataForm.dart';
import 'package:fishcount_app/screens/usuario/PessoaForm.dart';
import 'package:flutter/cupertino.dart';

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
