import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/model/enums/EnumTipoPagamento.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroScreen.dart';
import 'package:fishcount_app/service/PagamentoService.dart';
import 'package:fishcount_app/service/PlanoService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AlertDialogBuilder.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PlanoScreen {
  static final PlanoService _planoService = PlanoService();

  static final PagamentoService _pagamentoService = PagamentoService();

  static planoList(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _planoService.listarPlanos(),
        builder: (context, AsyncSnapshot<List<PlanoModel>> snapshot) {
          return AsyncSnapshotHandler(
            asyncSnapshot: snapshot,
            widgetOnError: const Text("Error"),
            widgetOnWaiting: const CircularProgressIndicator(),
            widgetOnEmptyResponse: _onEmptyResponse(),
            widgetOnSuccess: _onSuccessfulRequest(context, snapshot),
          ).handler();
        },
      ),
    );
  }

  static Text _onEmptyResponse() {
    return const Text("Não foi possível encontrar nenhum pagamento disponivel");
  }

  static SingleChildScrollView _onSuccessfulRequest(
      BuildContext context, AsyncSnapshot<List<PlanoModel>> snapshot) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
          itemBuilder: (context, index) {
            PlanoModel plano = snapshot.data![index];
            return Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              height: 200,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                  ),
                  left: BorderSide(
                    color: Colors.black26,
                  ),
                  right: BorderSide(
                    color: Colors.black26,
                  ),
                  top: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
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
                            buttonColor: Colors.white,
                            radioBorder: 10,
                            textSize: 17,
                            textColor: Colors.grey,
                            onPressed: () => _enviarContato(context),
                          ),
                          Container(
                            child: ElevatedButtonWidget(
                              buttonText: "Assine já",
                              buttonColor: Colors.blue,
                              radioBorder: 10,
                              textSize: 17,
                              textColor: Colors.white,
                              onPressed: () =>
                                  _confirmarAssinatura(context, plano),
                            ),
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
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
      ),
    );
  }

  static Future<String?> _confirmarAssinatura(
      BuildContext context, PlanoModel plano) async {
    final String descricaoPlano = plano.descricao;
    final String qtdeParcela = plano.qtdeParcela.toString();
    final String precoMax = plano.valorMaximo.toString();
    final double precoParcela = plano.valorMaximo / plano.qtdeParcela;
    final String description = 'Você selecionou o plano "$descricaoPlano"'
        '\nValor total de $precoMax'
        '\nEm $qtdeParcela parcelas de R\$ $precoParcela'
        '0';

    return AlertDialogBuilder(
      title: 'Confirmar Plano',
      description: description,
      leftButtonText: 'Cancelar',
      leftButtonFunction: () => Navigator.of(context).pop(),
      leftButtonColor: Colors.grey,
      rightButtonText: 'Confirmar',
      rightButtonFunction: _assinarPlano(plano, context),
      rightButtonColor: Colors.blue,
    ).build(context);
  }

  static _assinarPlano(PlanoModel plano, BuildContext context) async {
    final PagamentoModel pagamentoModel = _gerarPagamentoFromPlano(plano);

    dynamic response =
        await _pagamentoService.incluirAssinaturaPlano(pagamentoModel);
    if (response is PagamentoModel) {
      NavigatorUtils.pushReplacement(
          context,
          FinanceiroScreen(
            pagamentos: [response],
          ));
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  static Future<String?> _enviarContato(BuildContext context) async {
    return AlertDialogBuilder(
      title: 'Escolha sua preferência',
      description:
          'Selecione o meio de comunicação de sua preferência para que possamos entrar em contato.',
      leftButtonText: 'E-mail',
      leftButtonFunction: () => Navigator.of(context).pop(),
      rightButtonText: 'Whatsapp',
      rightButtonFunction: _launchWhatsApp,
    ).build(context);
  }

  static PagamentoModel _gerarPagamentoFromPlano(PlanoModel plano) {
    return PagamentoModel(
      null,
      plano.valorMinimo,
      plano.valorMinimo,
      0,
      0,
      plano.qtdeParcela,
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
