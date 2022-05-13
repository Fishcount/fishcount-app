import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/screens/usuario/UsuarioService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';

class UsuarioController extends AbstractController {
  Future<dynamic> salvarUsuario(BuildContext context, String nome, String email,
      String celular, String senha) async {
    EmailModel emailModel =
        EmailModel(null, email, EnumTipoEmail.PRINCIPAL.name);
    TelefoneModel telefoneModel =
        TelefoneModel(null, celular, EnumTipoTelefone.PRINCIPAL.name);
    UsuarioModel usuario =
        UsuarioModel(null, nome, senha, [telefoneModel], [emailModel], []);

    dynamic response = await UsuarioService().salvarOuAtualizarUsuario(usuario);
    if (response is UsuarioModel) {
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    }
    if (response is ErrorModel) {
      return getDefaultErrorMessage(context, response.message);
    }
  }
}
