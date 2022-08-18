import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';

import '../parcela/PagamentoParcelaScreen.dart';
import 'PagamentoService.dart';

class PagamentoController {
  static final PagamentoService _pagamentoService = PagamentoService();

  static pagamentoList(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _pagamentoService.buscarPagamentos(),
        builder: (context, AsyncSnapshot<List<PagamentoModel>> snapshot) {
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
    return const Text("Não foi possível encontrar nenhum pagamento para você.");
  }

  static SingleChildScrollView _onSuccessfulRequest(
      BuildContext context, AsyncSnapshot<List<PagamentoModel>> snapshot) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
          itemBuilder: (context, index) {
            final PagamentoModel pagamento = snapshot.data![index];
            return GestureDetector(
              onTap: () => _toParcelasList(context, pagamento.id!, pagamento.plano),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                height: 225,
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
                              pagamento.plano.descricao,
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
                              pagamento.statusPagamento,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    EnumStatusPagamentoHandler.getColorByStatus(
                                        pagamento.statusPagamento),
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
                                    'Inicio da vigência: ' +
                                        pagamento.dataInicioVigencia,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Fim da vigência: " +
                                        pagamento.dataFimVigencia,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Multa por atraso: R\$ ' +
                                        pagamento.acrescimo.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Desconto: R\$ ' +
                                        pagamento.desconto.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Valor Total: R\$ ' +
                                        pagamento.valor.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  static _toParcelasList(BuildContext context, int pagamentoId, PlanoModel plano) {
    NavigatorUtils.push(
      context,
      PagamentoParcelaScreen(
        pagamentId: pagamentoId,
        plano: plano
      ),
    );
  }
}
