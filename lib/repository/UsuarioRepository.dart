import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:fishcount_app/service/LoginService.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/EmailModel.dart';

class UsuarioRepository {
  dynamic save(BuildContext context, UsuarioModel usuarioModel) async {
    try {
      final db = await DBProvider().init();
      int idUsuario = await db.insert("usuario", usuarioModel.toLocalDataBase(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (idUsuario == 0){
        return ErrorHandler.getDefaultErrorMessage(context, ExceptionsMessage.serverError);
      }
      TelefoneRepository().save(context, usuarioModel.telefones.first, idUsuario);
      EmailRepository().save(context, usuarioModel.emails.first, idUsuario);

      SharedPreferencesUtils.addLocalSharedPreferences(idUsuario, usuarioModel);

      NavigatorUtils.pushReplacement(context, const LotesScreen());
    } on Exception catch (e) {
      return ErrorHandler.getDefaultErrorMessage(context, ExceptionsMessage.serverError);
    }
  }
}
