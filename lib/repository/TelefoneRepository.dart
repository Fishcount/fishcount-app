import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:flutter/cupertino.dart';

class TelefoneRepository{

  dynamic save(BuildContext context, TelefoneModel telefoneModel, int idUsuario) async {
    try {
      final db = await DBProvider().init();
      int idTelefone = await db.insert("telefone",telefoneModel.toLocalDataBase(idUsuario));

      if (idTelefone == 0){
        ErrorHandler.getDefaultErrorMessage(context, ExceptionsMessage.serverError);
      }
    } on Exception catch (e){
      ErrorHandler.getDefaultErrorMessage(context, ExceptionsMessage.serverError);
    }
  }
}