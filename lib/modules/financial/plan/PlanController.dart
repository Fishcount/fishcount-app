import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PlanModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/model/enums/EnumTipoPagamento.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AlertDialogBuilder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/AnimationUtils.dart';
import '../FinancialScreen.dart';
import '../payment/PaymentService.dart';
import 'PlanoService.dart';

class PlanController {
  static final PlanService _planoService = PlanService();

  static final PaymentService _pagamentoService = PaymentService();

  static planoList(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _planoService.listarPlanos(),
        builder: (context, AsyncSnapshot<List<PlanModel>> snapshot) {
          return AsyncSnapshotHandler(
            asyncSnapshot: snapshot,
            widgetOnError: const Text("Error"),
            widgetOnWaiting: Container(
              padding: const EdgeInsets.only(top: 30),
              child: AnimationUtils.progressiveDots(size: 50.0),
            ),
            widgetOnEmptyResponse: _onEmptyResponse(),
            widgetOnSuccess: _onSuccessfulRequest(context, snapshot),
          ).handler();
        },
      ),
    );
  }

  static Text _onEmptyResponse() {
    return const Text("Não foi possível encontrar nenhum plano disponivel");
  }

  static Widget _onSuccessfulRequest(
      BuildContext context, AsyncSnapshot<List<PlanModel>> snapshot) {
    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[100];
    return SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height / 1.4
          : MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data != null ? snapshot.data!.length : 0,
        itemBuilder: (context, index) {
          final PlanModel plano = snapshot.data![index];
          return Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            height: 200,
            decoration: BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
                left: BorderSide(
                  color: borderColor,
                ),
                right: BorderSide(
                  color: borderColor,
                ),
                top: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          plano.descricao,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          height: 1,
                          thickness: 2,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "R\$ " + plano.valorMaximo.toString() + "0",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Tenha entre " +
                                    plano.minTanque.toString() +
                                    " e " +
                                    plano.maxTanque.toString() +
                                    " tanques!",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Pague em " +
                                    plano.qtdeParcela.toString() +
                                    " parcelas!",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Negocie conosco para preços de até R\$ " +
                                    plano.valorMinimo.toString() +
                                    "0",
                                style: const TextStyle(fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButtonWidget(
                          buttonText: "Entrar em contato",
                          buttonColor: Colors.blue,
                          radioBorder: 10,
                          textSize: 17,
                          textColor: Colors.white,
                          onPressed: () => _enviarContato(context),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: ElevatedButtonWidget(
                            buttonText: "Assine já",
                            buttonColor: Colors.green,
                            radioBorder: 10,
                            textSize: 17,
                            textColor: Colors.white,
                            onPressed: () {
                              return _confirmarAssinatura(context, plano);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static Future<String?> _confirmarAssinatura(
      BuildContext context, PlanModel plano) async {
    final String descricaoPlano = plano.descricao;
    final String qtdeParcela = plano.qtdeParcela.toString();
    final String precoMax = plano.valorMaximo.toString();
    final double precoParcela = plano.valorParcelaMaximo;
    final String description = 'Você selecionou o plano "$descricaoPlano"'
        '\nValor total de $precoMax'
        '\nEm $qtdeParcela parcelas de R\$ $precoParcela';

    bool loading = false;

    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Confirmar Plano'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(description),
                  ],
                ),
              ),
              actions: <Widget>[
                loading
                    ? Center(
                        child: Container(
                          child: AnimationUtils.progressiveDots(size: 30.0),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButtonWidget(
                            buttonText: 'Cancelar',
                            buttonColor: Colors.blue,
                            textSize: 15,
                            textColor: Colors.white,
                            radioBorder: 10,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButtonWidget(
                            buttonText: 'Confirmar',
                            buttonColor: Colors.green,
                            textSize: 15,
                            textColor: Colors.white,
                            radioBorder: 10,
                            onPressed: () => {
                              setState(() => loading = true),
                              _assinarPlano(plano, context)
                            },
                          )
                        ],
                      )
              ],
            );
          },
        );
      },
    );
  }

  static _assinarPlano(PlanModel plano, BuildContext context) async {
    final PaymentModel paymentModel = _gerarPagamentoFromPlano(plano);

    dynamic response =
        await _pagamentoService.incluirAssinaturaPlano(paymentModel);
    if (response is PaymentModel) {
      NavigatorUtils.pushReplacementWithFadeAnimation(
          context,
          FinancialScreen(
            pagamentos: [response],
          ));
    }
    if (response is ErrorModel) {
      return ErrorHandler.getSnackBarError(context, response.message);
    }
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

  static PaymentModel _gerarPagamentoFromPlano(PlanModel plano) {
    return PaymentModel(
      null,
      plano.valorMinimo,
      plano.valorMinimo,
      0,
      0,
      plano.qtdeParcela,
      "",
      plano,
      EnumTipoPagamento.PIX.name,
      EnumStatusPagamento.ANALISE.name,
    );
  }

  static _launchWhatsApp() async {
    const String phoneNumber = '554598281323';
    const String message = 'Olá, tenho interesse nos planos da FishCount!';

    final Uri url =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');

    await launchUrl(url);
  }

  static _sendEmail() {
    // TODO chamar API para enviar email de interesse passando plano e pessoa
  }
}
