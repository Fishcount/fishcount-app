import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modules/financeiro/FinanceiroForm.dart';
import '../modules/financeiro/FinanceiroScreen.dart';
import '../modules/financeiro/pagamento/PagamentoService.dart';
import '../modules/lote/LotesController.dart';
import '../modules/usuario/PessoaDataForm.dart';
import '../modules/usuario/PessoaService.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final TextEditingController _cpfController = TextEditingController();

  Future<void> _resolverPermissoes() async {
    final List<PessoaModel> pessoas = await PessoaService().buscarPessoa();

    if (_pessoaHasCpf(pessoas.first)) {
      final List<PagamentoModel> pagamentos =
          await PagamentoService().buscarPagamentos();

      NavigatorUtils.push(
          context,
          FinanceiroScreen(
            pagamentos: pagamentos,
          ));
      return;
    }
    NavigatorUtils.push(context, FinanceiroForm(pessoaModel: pessoas.first));
  }

  bool _pessoaHasCpf(PessoaModel pessoa) =>
      pessoa.cpf != null && pessoa.cpf!.isNotEmpty;

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
              NavigatorUtils.push(context, const PessoaDataForm());
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
