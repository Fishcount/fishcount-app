import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/batch/BatchScreen.dart';

class UsuarioRepository {
  dynamic save(BuildContext context, PersonModel usuarioModel) async {
    try {
      final db = await DBProvider().init();
      int idUsuario = await db.insert("usuario", usuarioModel.toLocalDataBase(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (idUsuario == 0) {
        return ErrorHandler.getSnackBarError(
            context, ErrorMessage.serverError);
      }
      TelefoneRepository()
          .save(context, usuarioModel.phones.first, idUsuario);
      EmailRepository().save(context, usuarioModel.emails.first, idUsuario);

      SharedPreferencesUtils.addLocalSharedPreferences(idUsuario, usuarioModel);

      NavigatorUtils.pushReplacementWithFadeAnimation(context, const BatchScreen());
    } on Exception catch (e) {
      return ErrorHandler.getSnackBarError(
          context, ErrorMessage.serverError);
    }
  }

  dynamic login(BuildContext context, String email, String senha) async {
    try {
      final db = await DBProvider().init();
      List<Map<String, Object?>> login = await db.query("usuario",
          where: "email = ? and senha = ?", whereArgs: [email, senha]);

      if (login.isEmpty) {
        return ErrorHandler.getSnackBarError(
            context, ErrorMessage.loginInvalido);
      }
      NavigatorUtils.pushReplacementWithFadeAnimation(context, const BatchScreen());

      PersonModel usuarioModel = PersonModel.fromDatabase(login.first);
      SharedPreferencesUtils.addLocalSharedPreferences(
          usuarioModel.id!, usuarioModel);
    } on Exception catch (e) {
      return ErrorHandler.getSnackBarError(
          context, ErrorMessage.serverError);
    }
  }

  Future<PersonModel?> buscarUsuario(BuildContext context) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      }
      final db = await DBProvider().init();
      List<Map<String, Object?>> maps =
          await db.query("usuario", where: "id = ?", whereArgs: [userId]);

      late PersonModel person;
      List<PersonModel> people =  List.generate(maps.length, (index) {
        return PersonModel.fromDatabase(maps[index]);
      });
      return people.first;
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      return null;
    }
  }
}
