import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/PagamentoParcelaModel.dart';
import 'package:fishcount_app/model/enums/EnumMes.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../../generic/AbstractController.dart';
import 'PagamentoParcelaService.dart';

class PagamentoParcelaController extends AbstractController {
  static final PagamentoParcelaService pagamentoParcelaService =
      PagamentoParcelaService();

  static parcelasList(BuildContext context, int pagamentoId) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: pagamentoParcelaService.buscarPagamentosParcela(pagamentoId),
        builder:
            (context, AsyncSnapshot<List<PagamentoParcelaModel>> snapshot) {
          return AsyncSnapshotHandler(
            asyncSnapshot: snapshot,
            widgetOnError: const Text("Erro"),
            widgetOnWaiting: const CircularProgressIndicator(),
            widgetOnEmptyResponse: _onEmptyResponse(),
            widgetOnSuccess: _onSuccessfulRequest(context, snapshot),
          ).handler();
        },
      ),
    );
  }

  static Text _onEmptyResponse() {
    return const Text("Não foi possível encontrar nenhuma parcela para você.");
  }

  static SingleChildScrollView _onSuccessfulRequest(BuildContext context,
      AsyncSnapshot<List<PagamentoParcelaModel>> snapshot) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
          itemBuilder: (context, index) {
            final PagamentoParcelaModel parcela = snapshot.data![index];
            String mesParcela = parcela.dataVencimento.split('/')[1];

            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                alignment: Alignment.center,
                height: 190,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              MonthHandler(monthNumber: mesParcela).handle(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              parcela.statusPagamento,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    EnumStatusPagamentoHandler.getColorByStatus(
                                        parcela.statusPagamento),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: const Divider(
                          color: Colors.blue,
                          height: 5,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Multa por atraso: R\$ ' +
                                        parcela.acrescimo.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Desconto: R\$ ' +
                                        parcela.desconto.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Data Vencimento: ' +
                                        parcela.dataVencimento,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Valor total: R\$ ' +
                                        parcela.valor.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          parcela.statusPagamento != "FINALIZADO"
                              ? Container(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: ElevatedButtonWidget(
                                    buttonColor: Colors.blue,
                                    buttonText: "Pagar",
                                    onPressed: () {},
                                    radioBorder: 10,
                                    textColor: Colors.white,
                                    textSize: 15,
                                  ),
                                )
                              : const Text(""),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
