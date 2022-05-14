import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/repository/provider/DBProvider.dart';
import 'package:flutter/cupertino.dart';

class EmailRepository {
  dynamic save(
      BuildContext context, EmailModel emailModel, int idUsuario) async {
    try {
      final db = await DBProvider().init();
      int idEmail =
          await db.insert("email", emailModel.toLocalDatabase(idUsuario));

      if (idEmail == 0) {
        ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
      }
    } on Exception catch (e) {
      ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
    }
  }
}
