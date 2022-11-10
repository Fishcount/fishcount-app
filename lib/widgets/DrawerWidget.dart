import 'dart:io';

import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/modules/batch/BatchScreen.dart';
import 'package:fishcount_app/modules/login/LoginScreen.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:fishcount_app/utils/pdf/PdfUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../handler/AsyncSnapshotHander.dart';
import '../modules/batch/BatchController.dart';
import '../modules/financial/FinancialForm.dart';
import '../modules/financial/FinancialScreen.dart';
import '../modules/financial/payment/PaymentService.dart';
import '../modules/person/PessoaDataForm.dart';
import '../modules/person/PessoaService.dart';
import '../utils/FireBaseUtils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final PaymentService _paymentService = PaymentService();
  final PersonService _personService = PersonService();
  int? person;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtils.getIntVariableFromShared(
            EnumSharedPreferences.userId)
        .then((value) => setState(() => person = value));
  }

  Future<void> _handlePermissions() async {
    final PersonModel person = await _personService.findById();

    if (_personHasCpf(person)) {
      final List<PaymentModel> pagamentos =
          await _paymentService.buscarPagamentos();

      NavigatorUtils.pushWithFadeAnimation(
          context,
          FinancialScreen(
            pagamentos: pagamentos,
          ));
      return;
    }
    NavigatorUtils.pushWithFadeAnimation(
        context, FinancialForm(pessoaModel: person));
  }

  bool _personHasCpf(PersonModel pessoa) =>
      pessoa.cpf != null && pessoa.cpf!.isNotEmpty;

  bool loading = false;

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
      child: Image.network(
          snapshot.data!,
          fit: BoxFit.fitWidth,
          height: 70,
          width: 60,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          MediaQuery.of(context).orientation == Orientation.portrait
              ? DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.cyan[400]!,
                        Colors.cyan[50]!,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 85, right: 85),
                  child: person == null
                      ? CircleAvatar(
                          maxRadius: 70,
                          minRadius: 50,
                          child: Image.asset(ImagePaths.imageLogo),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        )
                      : FutureBuilder(
                          future: FireBaseUtils.loadImage(person!),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            return AsyncSnapshotHandler(
                              asyncSnapshot: snapshot,
                              widgetOnError: _onEmptyOrOnErrorImage(person!),
                              widgetOnEmptyResponse:
                                  _onEmptyOrOnErrorImage(person!),
                              widgetOnWaiting:
                                  AnimationUtils.progressiveDots(size: 40.0),
                              widgetOnSuccess:
                                  _imageOnSuccess(snapshot, person!),
                            ).handler();
                          },
                        ),
                )
              : Container(),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: BatchController().getUserEmail(),
                    height: 20,
                  ),
                )
              : Container(),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 5, bottom: 30),
                  child: SizedBox(
                    child: FutureBuilder(
                      future:
                          SharedPreferencesUtils.getStringVariableFromShared(
                              EnumSharedPreferences.userEmail),
                      builder: (BuildContext context,
                          AsyncSnapshot<String?> snapshot) {
                        return AsyncSnapshotHandler(
                          asyncSnapshot: snapshot,
                          widgetOnError: const Text(''),
                          widgetOnWaiting: const CircularProgressIndicator(),
                          widgetOnEmptyResponse: const Text(''),
                          widgetOnSuccess: Text(
                            snapshot.data == null ? '' : snapshot.data!,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ).handler();
                      },
                    ),
                    height: 20,
                  ),
                )
              : Container(),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => NavigatorUtils.pushWithFadeAnimation(
                context, const BatchScreen()),
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.person),
            title: const Text("Meus dados"),
            onTap: () => NavigatorUtils.pushWithFadeAnimation(
                context, const PessoaDataForm()),
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            tileColor: loading ? Colors.blueGrey.shade50 : null,
            leading: const Icon(Icons.monetization_on),
            trailing:
                loading ? AnimationUtils.progressiveDots(size: 30.0) : null,
            title: const Text("Financeiro"),
            onTap: () {
              setState(() => loading = true);
              _handlePermissions();
            },
          ),
          // const ListTile(
          //   isThreeLine: false,
          //   minVerticalPadding: 15,
          //   horizontalTitleGap: 15,
          //   leading: Icon(Icons.support_agent),
          //   title: Text("Suporte"),
          // ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Politica de privacidade"),
            onTap: () async {
              File file = await PdfUtils.loadPdf();
              PdfUtils.openPDF(context, file);
            },
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Sair"),
            onTap: () => NavigatorUtils.pushReplacementWithFadeAnimation(
                context, const LoginScreen()),
          ),
        ],
      ),
    );
  }
}
