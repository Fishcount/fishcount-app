import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:flutter/cupertino.dart';

class TanqueRepository{


  Future<List<TanqueModel>> listarTanques(BuildContext context, int loteId) async {
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
        return TanqueModel.fromJson(maps[index]);
      });
    } on Exception catch (e){
      ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
      return [];
    }
  }
}