import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/model/enums/EnumTipoPagamento.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroScreen.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/service/PagamentoService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanoController extends AbstractController {
  Widget listarPlanos(List<PlanoModel> planoModel, BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: planoModel.length,
          itemBuilder: (context, index) {
            PlanoModel plano = planoModel[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 180,
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
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
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
                        ),
                        const Expanded(
                          child: Divider(
                            height: 1,
                            thickness: 2,
                            color: Colors.blue,
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
                                  "Mínimo de tanques: " +
                                      plano.minTanque.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Máximo de tanques: " +
                                      plano.maxTanque.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Parcelas: " + plano.qtdeParcela.toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButtonWidget(
                                buttonText: "Assine já",
                                buttonColor: Colors.blue,
                                radioBorder: 10,
                                textSize: 17,
                                textColor: Colors.white,
                                onPressed: () => _assinarPlano(plano, context),
                              ),
                              ElevatedButtonWidget(
                                buttonText: "Entrar em contato",
                                buttonColor: Colors.white,
                                radioBorder: 3,
                                textSize: 17,
                                textColor: Colors.grey,
                                onPressed: _enviarContato,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Valor total do plano: R\$ " +
                                plano.valorMinimo.toString() +
                                "0",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _assinarPlano(PlanoModel plano, BuildContext context) async {
    final PagamentoModel pagamentoModel = _gerarPagamentoFromPlano(plano);

    dynamic response = await _incluirAssinaturaPlano(pagamentoModel);
    if (response is PagamentoModel) {
      NavigatorUtils.pushReplacement(context, FinanceiroScreen(pagamentos: [response],));
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  PagamentoModel _gerarPagamentoFromPlano(PlanoModel plano) {
    return PagamentoModel(
        null,
        plano.valorMinimo,
        plano.valorMinimo,
        0,
        0,
        plano.qtdeParcela,
        plano,
        EnumTipoPagamento.PIX.name,
        EnumStatusPagamento.ANALISE.name);
  }

  Future<dynamic> _incluirAssinaturaPlano(PagamentoModel pagamentoModel) async {
    return await PagamentoService().incluirAssinaturaPlano(pagamentoModel);
  }

  _enviarContato() {}
}
