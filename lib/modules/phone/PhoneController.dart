import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:fishcount_app/widgets/ItemContainerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generic/AbstractController.dart';
import '../person/PessoaDataForm.dart';
import 'PhoneForm.dart';

class PhoneController extends AbstractController {

  Future<dynamic> salvarTelefone(BuildContext context, PhoneModel telefoneModel) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("chamar api");
    }
    return saveLocal(context, telefoneModel);
  }

  Future<dynamic> saveLocal(context, PhoneModel telefoneModel) async{
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

    NavigatorUtils.pushReplacement(context, const PessoaDataForm());
  }

  Widget getPhoneList(BuildContext context, List<PhoneModel> telefones) {
    if (telefones.isEmpty){
      return FutureBuilder(
        future: TelefoneRepository().listarTelefones(context),
        builder: (context, AsyncSnapshot<List<PhoneModel>> snapshot) {
          if (snapshot.hasData) {
            return _getTelefoneItem(snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return _getTelefoneItem(telefones);
  }

  Container _getTelefoneItem(List<PhoneModel> telefones) {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemCount: telefones.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ItemContainerWidget(
            titles: telefones[index].phoneNumber,
            subTitles: telefones[index].phoneType,
            prefixIcon: const Icon(Icons.phone_android),
            onChange: () => NavigatorUtils.push(
              context,
              PhoneForm(telefoneModel: telefones[index]),
            ),
            onDelete: () {},
          );
        },
      ),
    );
  }

}