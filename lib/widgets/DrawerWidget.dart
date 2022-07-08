import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroForm.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroScreen.dart';
import 'package:fishcount_app/screens/lote/LotesController.dart';
import 'package:fishcount_app/screens/usuario/UsuarioDataForm.dart';
import 'package:fishcount_app/service/PessoaService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final TextEditingController _cpfController = TextEditingController();

  Future<void> _showMyDialog(PessoaModel pessoaModel) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complete seu cadastro!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextFieldWidget(
                    controller: _cpfController,
                    hintText: "CPF",
                    labelText: "Informe seu cpf",
                    iconColor: Colors.blueGrey,
                    obscureText: false,
                    focusedBorderColor: Colors.blueGrey,
                    inputMask: Formatters.cpfFormat,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () async {
                pessoaModel.cpf = _cpfController.text;
                dynamic response = await PessoaService().salvarOuAtualizarUsuario(pessoaModel);

                if (response is PessoaModel) {
                  NavigatorUtils.push(context, const FinanceiroScreen());
                }
                if (response is ErrorModel) {
                  ErrorHandler.getDefaultErrorMessage(context, response);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resolverPermissoes() async {
    final List<PessoaModel> pessoas = await PessoaService().buscarPessoa();
    final PessoaModel pessoa = pessoas.first;

    if (pessoa.cpf == null || pessoa.cpf.isEmpty) {
      NavigatorUtils.push(context, FinanceiroForm(pessoaModel: pessoa));
      return;
    }

    NavigatorUtils.push(context, const FinanceiroScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
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
          ),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              child: LotesController().getUserEmail(),
              height: 20,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 5, bottom: 30),
            child: const SizedBox(
              child: Text(
                "emaildocaboclo@gmail.com",
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              height: 20,
            ),
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.person),
            title: const Text("Meus dados"),
            onTap: () {
              NavigatorUtils.push(context, const UsuarioDataForm());
            },
          ),
          ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: const Icon(Icons.monetization_on),
            title: const Text("Financeiro"),
            // onTap: () => NavigatorUtils.push(context, const FinanceiroScreen()),
            onTap: () => _resolverPermissoes(),
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
            padding: const EdgeInsets.only(left: 30, right: 40, top: 220),
            child: ElevatedButtonWidget(
              buttonText: "Sair",
              buttonColor: Colors.cyan.shade600,
              textColor: Colors.white,
              textSize: 20,
              radioBorder: 50,
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppPaths.loginPath);
              },
            ),
          ),
        ],
      ),
    );
  }
}
