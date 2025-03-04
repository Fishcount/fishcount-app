import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:flutter/cupertino.dart';

class TanqueRepository{


  Future<List<TankModel>> listarTanques(BuildContext context, int loteId) async {
    try {
      final db = await DBProvider().init();

      List<Map<String, Object?>> maps = await db.query(
        "tanque",
        where: "id_lote = ?",
        whereArgs: [loteId],
        orderBy: "descricao desc",
      );

      if (maps.isEmpty){
        return [];
      }

      return List.generate(maps.length, (index) {
        return TankModel.fromJson(maps[index]);
      });
    } on Exception catch (e){
      ErrorHandler.getSnackBarError(context, ErrorMessage.serverError);
      return [];
    }
  }
}