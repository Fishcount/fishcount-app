import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';

import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';

import '../modules/lote/LotesScreen.dart';

class LoteRepository {
  dynamic save(BuildContext context, LoteModel loteModel) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        return ErrorHandler.getDefaultErrorMessage(
            context, ErrorMessage.serverError);
      }

      final db = await DBProvider().init();
      int idlote = await db.insert("lote", loteModel.toLocalDatabase(userId));
      if (idlote == 0) {
        return ErrorHandler.getDefaultErrorMessage(
            context, ErrorMessage.serverError);
      }
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    } on Exception catch (e) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }
  }

  dynamic update(BuildContext context, LoteModel loteModel) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        return ErrorHandler.getDefaultErrorMessage(
            context, ErrorMessage.serverError);
      }

      final db = await DBProvider().init();
      int idlote = await db.update(
        "lote",
        loteModel.toLocalDatabase(userId),
        where: "id = ?",
        whereArgs: [loteModel.id],
      );
      if (idlote == 0) {
        return ErrorHandler.getDefaultErrorMessage(
            context, ErrorMessage.serverError);
      }
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    } on Exception catch (e) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }
  }

  Future<List<LoteModel>> listarLotesUsuario(BuildContext context) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      if (userId == null) {
        ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
        return [];
      }

      final db = await DBProvider().init();

      List<Map<String, Object?>> maps = await db.query(
        "lote",
        where: "id_usuario = ?",
        whereArgs: [userId],
        orderBy: "descricao desc",
      );

      if (maps.isEmpty) {
        return [];
      }

      return List.generate(maps.length, (index) {
        return LoteModel.fromJson(maps[index]);
      });
    } on Exception catch (e) {
      ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
      return [];
    }
  }
}
