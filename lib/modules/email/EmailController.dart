import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';

import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:fishcount_app/widgets/ItemContainerWidget.dart';
import 'package:flutter/material.dart';



import '../generic/AbstractController.dart';
import '../person/PessoaDataForm.dart';
import 'EmailForm.dart';
import 'EmailService.dart';

class EmailController extends AbstractController {



  Future<dynamic> salvarEmail(
      BuildContext context, EmailModel emailModel) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return _saveOrUpdate(context, emailModel);
    }
    return _saveLocal(context, emailModel);
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
            titles: emails[index].email,
            subTitles: emails[index].emailType,
            prefixIcon: const Icon(Icons.email),
            onChange: () => NavigatorUtils.push(
              context,
              EmailForm(
                emailModel: emails[index],
              ),
            ),
            onDelete: () {
              bool excluir =
                  emails[index].emailType != EnumTipoEmail.PRINCIPAL.name;
              return showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Excluir e-mail'),
                  content: _resolverConteudoAlert(excluir),
                  actions: <Widget>[
                    _resolverOpcaoNegativa(excluir, context),
                    _resolverOpcaoPositiva(excluir, context, emails[index].id!),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  TextButton _resolverOpcaoPositiva(
      bool excluir, BuildContext context, int emailId) {
    return TextButton(
      onPressed: () =>
          excluir ? _excluirEmail(context, emailId) : Navigator.pop(context, 'Voltar'),
      child: excluir ? const Text('Sim') : const Text('Voltar'),
    );
  }

  Widget _resolverOpcaoNegativa(bool excluir, BuildContext context) {
    return excluir
        ? TextButton(
            onPressed: () => Navigator.pop(context, 'Não'),
            child: const Text('Não'),
          )
        : const Text("");
  }

  Text _resolverConteudoAlert(bool excluir) => excluir
      ? const Text('Deseja realmente excluir esse e-mail?')
      : const Text('Você não pode excluir o seu e-mail de login.');

  Future<dynamic> _saveLocal(
      BuildContext context, EmailModel emailModel) async {
    int? userId = await _getUserId();
    if (userId == null) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }
    await _resolverSaveOrUpdateLocal(emailModel, context, userId);

    NavigatorUtils.pushReplacement(context, const PessoaDataForm());
  }

  Future<void> _resolverSaveOrUpdateLocal(
      EmailModel emailModel, BuildContext context, int userId) async {
    if (emailModel.id == null) {
      await EmailRepository().save(context, emailModel, userId);
    } else {
      await EmailRepository().update(context, emailModel, userId);
    }
  }

  Future<dynamic> _saveOrUpdate(
      BuildContext context, EmailModel emailModel) async {
    int? userId = await _getUserId();
    if (userId == null) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }
    dynamic response = await _resolverSaveOrUpdate(emailModel, userId);
    if (response is EmailModel) {
      NavigatorUtils.pushReplacement(context, const PessoaDataForm());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  Future<dynamic> _excluirEmail(BuildContext context, int emailId) async {
    int? userId = await _getUserId();
    if (userId == null) {
      return ErrorHandler.getDefaultErrorMessage(
          context, ErrorMessage.serverError);
    }
    dynamic response = await EmailService().deleteEmail(emailId, userId);
    if (response == emailId) {
      NavigatorUtils.pushReplacement(context, const PessoaDataForm());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  Future<int?> _getUserId() async {
    return await SharedPreferencesUtils.getIntVariableFromShared(
        EnumSharedPreferences.userId);
  }

  Future<dynamic> _resolverSaveOrUpdate(
      EmailModel emailModel, int userId) async {
    if (emailModel.id == null) {
      return EmailService().save(emailModel, userId);
    }
    return EmailService().update(emailModel, userId);
  }
}
