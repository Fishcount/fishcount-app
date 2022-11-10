import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';

class TelefoneRepository {
  dynamic save(
      BuildContext context, PhoneModel telefoneModel, int idUsuario) async {
    try {
      final db = await DBProvider().init();
      int idTelefone =
          await db.insert("telefone", telefoneModel.toLocalDataBase(idUsuario));

      if (idTelefone == 0) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      }
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
    }
  }

  Future<List<PhoneModel>> listarTelefones(BuildContext context) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
        return [];
      }
      final db = await DBProvider().init();
      List<Map<String, Object?>> maps = await db.query(
        "telefone",
        where: "id_usuario = ?",
        whereArgs: [userId],
      );

      if (maps.isEmpty) {
        return [];
      }
      return List.generate(maps.length, (index) {
        return PhoneModel.fromJson(maps[index]);
      });
    } on Exception catch (e) {
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      return [];
    }
  }

  dynamic update(context, PhoneModel telefoneModel, int userId) async {
    try {
      final db = await DBProvider().init();
      int idTelefone = await db.update(
        "telefone",
        telefoneModel.toLocalDataBase(userId),
        where: "id = ?",
        whereArgs: [telefoneModel.id],
      );

      if (idTelefone == 0){
        ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      }
    } on Exception catch (e){
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
    }
  }
}
