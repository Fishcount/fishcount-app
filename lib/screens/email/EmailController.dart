import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/screens/email/EmailForm.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/usuario/UsuarioDataForm.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:fishcount_app/widgets/ItemContainerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailController extends AbstractController {
  Future<dynamic> salvarEmail(
      BuildContext context, EmailModel emailModel) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("chamar api");
    }
    return saveLocal(context, emailModel);
  }

  Widget getEmailList(BuildContext context, List<EmailModel> emails) {
    if (emails.isEmpty) {
      return FutureBuilder(
        future: EmailRepository().listarEmails(context),
        builder: (context, AsyncSnapshot<List<EmailModel>> snapshot) {
          if (snapshot.hasData) {
            return _getEmailItem(snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }
    return _getEmailItem(emails);
  }

  Container _getEmailItem(List<EmailModel> emails) {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemCount: emails.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ItemContainerWidget(
            titles: emails[index].descricao,
            subTitles: emails[index].tipoEmail,
            prefixIcon: const Icon(Icons.email),
            onChange: () => NavigatorUtils.push(
              context,
              EmailForm(
                emailModel: emails[index],
              ),
            ),
            onDelete: () {},
          );
        },
      ),
    );
  }

  Future<dynamic> saveLocal(BuildContext context, EmailModel emailModel) async {
    int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
        EnumSharedPreferences.userId);
    if (userId == null) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }

    if (emailModel.id == null) {
      await EmailRepository().save(context, emailModel, userId);
    } else {
      await EmailRepository().update(context, emailModel, userId);
    }

    NavigatorUtils.pushReplacement(context, const UsuarioDataForm());
  }
}
