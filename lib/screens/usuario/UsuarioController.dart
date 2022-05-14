import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/service/UsuarioService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/cupertino.dart';

class UsuarioController extends AbstractController {
  Future<dynamic> salvarUsuario(BuildContext context, String nome, String email,
      String celular, String senha) async {
    ConnectionUtils().isConnected().then((isConnected) {
      if (isConnected) {
        return saveWithApi(context, email, celular, nome, senha);
      }
      return saveLocal(context, email, celular, nome, senha);
    });
  }

  Future<dynamic> saveLocal(BuildContext context, String email, String celular,
      String nome, String senha) async {
    UsuarioModel usuario = createUsuarioModel(email, celular, nome, senha);

    return await UsuarioRepository().save(context, usuario);
  }

  Future<dynamic> saveWithApi(BuildContext context, String email,
      String celular, String nome, String senha) async {
    UsuarioModel usuario = createUsuarioModel(email, celular, nome, senha);

    dynamic response = await UsuarioService().salvarOuAtualizarUsuario(usuario);
    if (response is UsuarioModel) {
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  UsuarioModel createUsuarioModel(
      String email, String celular, String nome, String senha) {
    EmailModel emailModel =
        EmailModel(null, email, EnumTipoEmail.PRINCIPAL.name);
    TelefoneModel telefoneModel =
        TelefoneModel(null, celular, EnumTipoTelefone.PRINCIPAL.name);

    return UsuarioModel(null, nome, senha, [telefoneModel], [emailModel], []);
  }
}
