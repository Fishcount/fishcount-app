import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/modules/financial/payment/PaymentController.dart';
import 'package:fishcount_app/modules/financial/plan/PlanController.dart';
import 'package:fishcount_app/modules/person/PessoaDataForm.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/custom/BottomSheetBuilder.dart';

class FinancialScreen extends StatefulWidget {
  final List<PaymentModel>? pagamentos;

  const FinancialScreen({
    Key? key,
    this.pagamentos,
  }) : super(key: key);

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  bool _showPagamentos() {
    return widget.pagamentos != null && widget.pagamentos!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      drawer: const DrawerWidget(),
      bottomSheet: CustomBottomSheet(
        context: context,
        newFunction: () {},
        rightElement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.support_agent,
                  size: 35,
                  color: Colors.white,
                ),
                onTap: () => _enviarContato(context),
              ),
              const Text(
                "Suporte",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        centerElement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.white,
                ),
                onTap: () => NavigatorUtils.pushWithFadeAnimation(context, const PessoaDataForm()),
              ),
              const Text(
                "Meus Dados",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ).build(),
      body: Container(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DividerWidget(
                textBetween: _showPagamentos()
                    ? "Planos escolhidos"
                    : "Planos disponíveis",
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                isBold: true,
              ),
              _showPagamentos()
                  ? PagamentoController.pagamentoList(context)
                  : PlanController.planoList(context),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String?> _enviarContato(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escolha sua preferência'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Selecione o meio de comunicação de sua preferência para que possamos entrar em contato.'),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: 'Enviar E-mail',
                  buttonColor: Colors.blue,
                  onPressed: () => Navigator.of(context).pop(),
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: 'Whatsapp',
                  buttonColor: Colors.green,
                  onPressed: () => _launchWhatsApp(),
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                )
              ],
            )
          ],
        );
      },
    );
  }

  static _launchWhatsApp() async {
    const String phoneNumber = '554598281323';
    const String message = 'Olá, poderia me auxiliar com os meus planos contratados da fishcount?';

    final Uri url =
    Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');

    await launchUrl(url);
  }
}
