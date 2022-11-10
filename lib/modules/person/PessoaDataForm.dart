import 'dart:io';

import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/modules/email/EmailForm.dart';
import 'package:fishcount_app/modules/email/EmailService.dart';
import 'package:fishcount_app/modules/phone/PhoneForm.dart';
import 'package:fishcount_app/modules/phone/PhoneService.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/buttons/TextButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/FireBaseUtils.dart';
import 'PessoaService.dart';

class PessoaDataForm extends StatefulWidget {
  const PessoaDataForm({Key? key}) : super(key: key);

  @override
  State<PessoaDataForm> createState() => _PessoaDataFormState();
}

class _PessoaDataFormState extends State<PessoaDataForm>
    with TickerProviderStateMixin {
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  bool loading = false;
  late String urlperfilPhoto;

  final PersonService _personService = PersonService();
  final EmailService _emailService = EmailService();
  final PhoneService _phoneService = PhoneService();

  final String _text = '';

  Future<PersonModel?> buscarUsuario() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return _personService.findById();
    }
    return UsuarioRepository().buscarUsuario(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: FutureBuilder(
            future: buscarUsuario(),
            builder: (context, AsyncSnapshot<PersonModel?> snapshot) {
              return AsyncSnapshotHandler(
                asyncSnapshot: snapshot,
                widgetOnError: const Text(
                    "Ocorreu um erro nos nossos servidores, por favor, entre em contato."),
                widgetOnEmptyResponse: CircleAvatar(),
                widgetOnWaiting: Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: AnimationUtils.progressiveDots(size: 50.0),
                ),
                widgetOnSuccess: _onSuccess(snapshot.data, context),
              ).handler();
            },
          ),
        ),
      ),
    );
  }

  _onSuccess(PersonModel? personModel, BuildContext context) {
    if (personModel == null ||
        personModel.emails.isEmpty ||
        personModel.phones.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        child: AnimationUtils.progressiveDots(size: 50.0),
      );
    }
    final PersonModel person = personModel;
    // Variáveis de email
    final List<EmailModel> emails = person.emails;
    final bool isEmailExpansion = emails.length > 1;
    final EmailModel principalEmail = person.emails.first;
    emails.remove(principalEmail);

    // Variáveis de telefone
    final List<PhoneModel> phones = person.phones;
    final bool isPhoneExpansion = phones.length > 1;
    final PhoneModel principalPhone = person.phones.first;
    phones.remove(principalPhone);

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: DividerWidget(
            widgetBetween: SizedBox(
              width: 115,
              height: 115,
              child: Stack(
                children: [
                  FutureBuilder(
                    future: FireBaseUtils.loadImage(person.id!),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return AsyncSnapshotHandler(
                        asyncSnapshot: snapshot,
                        widgetOnError: _onEmptyOrOnErrorImage(person.id),
                        widgetOnEmptyResponse:
                            _onEmptyOrOnErrorImage(person.id),
                        widgetOnWaiting:
                            AnimationUtils.progressiveDots(size: 40.0),
                        widgetOnSuccess: _imageOnSuccess(snapshot, person.id),
                      ).handler();
                    },
                  ),
                ],
              ),
            ),
            thikness: 2,
            paddingRight: 10,
            paddingLeft: 10,
            height: 1,
            color: Colors.blue,
            isBold: false,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              right: BorderSide(color: Colors.grey),
              left: BorderSide(
                color: Colors.grey,
              ),
              top: BorderSide(
                color: Colors.grey,
              ),
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: ExpansionTile(
            leading: const Icon(Icons.mail),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    principalEmail.email,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Flexible(
                  child: Text(
                    principalEmail.emailType,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            children: [
              isEmailExpansion
                  ? SizedBox(
                      height: emails.length < 2
                          ? emails.isEmpty
                              ? 0
                              : 50
                          : 100,
                      child: ListView.builder(
                        itemCount: emails.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(principalEmail.id!.toString()),
                            onDismissed: (direction) => _showAlertDialog(
                              context,
                              person.id!,
                              emails,
                              index,
                              'email',
                              () async => {
                                await _emailService.deleteEmail(
                                    emails[index].id!, person.id!),
                                Navigator.pop(context),
                                setState(() {
                                  emails.removeAt(index);
                                }),
                              },
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red[400],
                              ),
                              margin: const EdgeInsets.only(right: 10),
                              child: Container(
                                alignment: const Alignment(-0.9, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: const Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: ExpansionTile(
                              leading: const Icon(Icons.mail),
                              trailing: GestureDetector(
                                child: const Icon(Icons.edit),
                                onTap: () =>
                                    NavigatorUtils.pushWithFadeAnimation(
                                  context,
                                  EmailForm(
                                    emailModel: emails[index],
                                  ),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      emails[index].email,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      emails[index].emailType,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              Container(
                alignment: Alignment.center,
                child: TextButtonWidget(
                  buttonText: "Adicionar Email",
                  textColor: Colors.green,
                  textSize: 16,
                  onPressed: () => NavigatorUtils.pushWithFadeAnimation(
                      context, const EmailForm()),
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "Telefones".toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Expanded(
                child: Divider(
                  height: 2,
                  thickness: 1,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              right: BorderSide(color: Colors.grey),
              left: BorderSide(
                color: Colors.grey,
              ),
              top: BorderSide(
                color: Colors.grey,
              ),
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.phone),
                Flexible(
                  flex: 2,
                  child: Text(
                    principalPhone.phoneNumber,
                    // style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Flexible(
                  child: Text(
                    principalPhone.phoneType,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            children: [
              isPhoneExpansion
                  ? SizedBox(
                      height: phones.length < 2
                          ? phones.isEmpty
                              ? 0
                              : 50
                          : 100,
                      child: ListView.builder(
                        itemCount: phones.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(principalPhone.id!.toString()),
                            onDismissed: (direction) => _showAlertDialog(
                              context,
                              person.id!,
                              emails,
                              index,
                              'telefone',
                              () async => {
                                await _phoneService.delete(
                                    phones[index].id!, person.id!),
                                Navigator.pop(context),
                                setState(() {
                                  phones.removeAt(index);
                                }),
                              },
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red[400],
                              ),
                              margin: const EdgeInsets.only(right: 10),
                              child: Container(
                                alignment: const Alignment(-0.9, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: const Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: ExpansionTile(
                              trailing: GestureDetector(
                                child: const Icon(Icons.edit),
                                onTap: () =>
                                    NavigatorUtils.pushWithFadeAnimation(
                                  context,
                                  PhoneForm(
                                    telefoneModel: phones[index],
                                  ),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.phone),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      phones[index].phoneNumber,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      phones[index].phoneType,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              Container(
                alignment: Alignment.center,
                child: TextButtonWidget(
                  buttonText: "Adicionar Telefone",
                  textColor: Colors.green,
                  textSize: 16,
                  onPressed: () => NavigatorUtils.pushWithFadeAnimation(
                      context, const PhoneForm()),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _onEmptyOrOnErrorImage(int? personId) {
    if (personId == null) {
      return AnimationUtils.progressiveDots(size: 40.0);
    }
    return GestureDetector(
      onTap: () => FireBaseUtils.pickAndUploadImage(
          personId,
          () => setState(() => uploading = true),
          () => setState(() => uploading = false)),
      child: const CircleAvatar(
        maxRadius: 70,
        minRadius: 50,
        child: Icon(Icons.person_add_alt_1, size: 50),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _imageOnSuccess(AsyncSnapshot<String> snapshot, int? personId) {
    if (!snapshot.hasData || personId == null) {
      return AnimationUtils.progressiveDots(size: 40.0);
    }
    return GestureDetector(
      onTap: () => FireBaseUtils.pickAndUploadImage(
          personId,
          () => setState(() => uploading = true),
          () => setState(() => uploading = false)),
      child: CircleAvatar(
        radius: 70,
        child: Image.network(
          snapshot.data!,
          width: 100,
          height: 100,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }

  Future<String?> _showAlertDialog(BuildContext context, int personId,
      List<dynamic> list, int index, String entity, Function() onConfirm) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Deseja realmente excluir esse $entity? "),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: "Cancelar",
                  buttonColor: Colors.blue,
                  onPressed: () => {
                    Navigator.pop(context),
                    setState(() {
                      list.removeAt(index);
                    }),
                  },
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: "Confirmar",
                  buttonColor: Colors.green,
                  onPressed: onConfirm,
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
