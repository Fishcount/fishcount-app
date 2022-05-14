import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoteRepository {
  Future<List<LoteModel>> listarLotesUsuario(BuildContext context) async {
    try {
      SharedPreferences prefs =
          await SharedPreferencesUtils.getSharedPreferences();
      int? userId = prefs.getInt("userId");

      final db = await DBProvider().init();

      List<Map<String, Object?>> maps = await db.query(
        "lote",
        where: "id_usuario = ?",
        whereArgs: [userId],
        orderBy: "descricao desc",
      );

      if (maps.isEmpty){
        return [];
      }

      return List.generate(maps.length, (index) {
        return LoteModel.fromJson(maps[index]);
      });
    } on Exception catch (e){
      ErrorHandler.getDefaultErrorMessage(context, ExceptionsMessage.serverError);
      return [];
    }
  }
}
