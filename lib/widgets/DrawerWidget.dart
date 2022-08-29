import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/modules/batch/BatchScreen.dart';
import 'package:fishcount_app/modules/login/LoginScreen.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../handler/AsyncSnapshotHander.dart';
import '../modules/batch/BatchController.dart';
import '../modules/financial/FinancialForm.dart';
import '../modules/financial/FinancialScreen.dart';
import '../modules/financial/payment/PaymentService.dart';
import '../modules/person/PessoaDataForm.dart';
import '../modules/person/PessoaService.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  Future<void> _handlePermissions() async {
    final PersonModel people = await PersonService().findById();

    if (_pessoaHasCpf(people)) {
      final List<PaymentModel> pagamentos =
          await PagamentoService().buscarPagamentos();

      NavigatorUtils.push(
          context,
          FinancialScreen(
            pagamentos: pagamentos,
          ));
      return;
    }
    NavigatorUtils.push(context, FinancialForm(pessoaModel: people));
  }

  bool _pessoaHasCpf(PersonModel pessoa) =>
      pessoa.cpf != null && pessoa.cpf!.isNotEmpty;

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
                  child: CircleAvatar(
                    maxRadius: 70,
                    minRadius: 50,
                    child: Image.asset(ImagePaths.imageLogo),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
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
            onTap: () => NavigatorUtils.push(context, const BatchScreen()),
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.person),
            title: const Text("Meus dados"),
            onTap: () => NavigatorUtils.push(context, const PessoaDataForm()),
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.monetization_on),
            title: const Text("Financeiro"),
            onTap: () => _handlePermissions(),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.support_agent),
            title: Text("Suporte"),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.privacy_tip),
            title: Text("Politica de privacidade"),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 30,
                right: 40,
                top: MediaQuery.of(context).orientation == Orientation.portrait
                    ? 220
                    : 40),
            child: ElevatedButtonWidget(
              buttonText: "Sair",
              buttonColor: Colors.cyan.shade600,
              textColor: Colors.white,
              textSize: 20,
              radioBorder: 50,
              onPressed: () =>
                  NavigatorUtils.pushReplacement(context, const LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
