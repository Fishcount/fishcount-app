import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/usuario/UsuarioDataForm.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';

class EmailController extends AbstractController {
  Future<dynamic> salvarEmail(BuildContext context, EmailModel emailModel) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("chamar api");
    }
    return saveLocal(context, emailModel);
  }

  Future<dynamic> saveLocal(BuildContext context, EmailModel emailModel) async {

    int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
        EnumSharedPreferences.userId);
    if (userId == null){
      return ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
    }

    if (emailModel.id == null){
      await EmailRepository().save(context, emailModel, userId);

    } else{
      await EmailRepository().update(context, emailModel, userId);
    }

    NavigatorUtils.pushReplacement(context, const UsuarioDataForm());
  }
}
