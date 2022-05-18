import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:flutter/cupertino.dart';

class EspecieRepository {
  Future<List<EspecieModel>> listar(BuildContext context) async {
    try {
      final db = await DBProvider().init();
      List<Map<String, Object?>> maps = await db.query("especie");

      if (maps.isEmpty) {
        return [];
      }
      return List.generate(maps.length, (index) {
        return EspecieModel.fromJson(maps[index]);
      });
    } on Exception catch (e) {
      ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
      return [];
    }
  }
}
