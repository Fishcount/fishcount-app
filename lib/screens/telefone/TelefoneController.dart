import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/usuario/UsuarioDataForm.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:flutter/cupertino.dart';

class TelefoneController extends AbstractController{

  Future<dynamic> salvarTelefone(BuildContext context, TelefoneModel telefoneModel) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("chamar api");
    }
    return saveLocal(context, telefoneModel);
  }

  Future<dynamic> saveLocal(context, TelefoneModel telefoneModel) async{
    int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
        EnumSharedPreferences.userId);
    if (userId == null){
      return ErrorHandler.getDefaultErrorMessage(context, ErrorMessage.serverError);
    }

    if(telefoneModel.id == null){
      await TelefoneRepository().save(context, telefoneModel, userId);
    } else {
      await TelefoneRepository().update(context, telefoneModel, userId);
    }

    NavigatorUtils.pushReplacement(context, const UsuarioDataForm());
  }

}