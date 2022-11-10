import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';

class EmailRepository {
  dynamic save(
      BuildContext context, EmailModel emailModel, int idUsuario) async {
    try {
      final db = await DBProvider().init();
      int idEmail =
          await db.insert("email", emailModel.toLocalDatabase(idUsuario));

      if (idEmail == 0) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      }
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
    }
  }

  dynamic update(
      BuildContext context, EmailModel emailModel, int idUsuario) async {
    try {
      final db = await DBProvider().init();
      int idEmail = await db.update(
        "email",
        emailModel.toLocalDatabase(idUsuario),
        where: "id = ?",
        whereArgs: [emailModel.id],
      );

      if (idEmail == 0) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      }
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
    }
  }

  Future<List<EmailModel>> listarEmails(BuildContext context) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
        return [];
      }
      final db = await DBProvider().init();
      List<Map<String, Object?>> maps = await db.query(
        "email",
        where: "id_usuario = ?",
        whereArgs: [userId],
      );

      if (maps.isEmpty) {
        return [];
      }
      return List.generate(maps.length, (index) {
        return EmailModel.fromJson(maps[index]);
      });
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      return [];
    }
  }
}
