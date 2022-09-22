import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PlanModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../utils/AnimationUtils.dart';
import '../installment/PaymentInstallmentScreen.dart';
import 'PaymentService.dart';

class PagamentoController {
  static final PaymentService _pagamentoService = PaymentService();

  static pagamentoList(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: FutureBuilder(
          future: _pagamentoService.buscarPagamentos(),
          builder: (context, AsyncSnapshot<List<PaymentModel>> snapshot) {
            return AsyncSnapshotHandler(
              asyncSnapshot: snapshot,
              widgetOnError: const Text("Erro"),
              widgetOnWaiting: _onWaitingResponse(),
              widgetOnEmptyResponse: _onEmptyResponse(),
              widgetOnSuccess: _onSuccessfulRequest(context, snapshot),
            ).handler();
          },
        ),
      ),
    );
  }

  static _onEmptyResponse() =>
      const Text("Não foi possível encontrar nenhum pagamento para você.");

  static _onWaitingResponse() => Container(
        padding: const EdgeInsets.only(top: 100),
        child: AnimationUtils.bouncingBall(size: 50.0),
      );

  static SingleChildScrollView _onSuccessfulRequest(
      BuildContext context, AsyncSnapshot<List<PaymentModel>> snapshot) {
    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[100];
    return SingleChildScrollView(
      child: SizedBox(
        height:MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.3
            : MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
          itemBuilder: (context, index) {
            final PaymentModel pagamento = snapshot.data![index];
            return GestureDetector(
              onTap: () =>
                  _toParcelasList(context, pagamento.id!, pagamento.plan),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                height: 225,
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
                  color: Colors.white38,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              pagamento.plan.descricao,
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
                              pagamento.paymentStatus,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    EnumStatusPagamentoHandler.getColorByStatus(
                                        pagamento.paymentStatus),
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
                                        pagamento.startValidityDate,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Fim da vigência: " +
                                        pagamento.endValidityDate,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Multa por atraso: R\$ ' +
                                        pagamento.increase.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Desconto: R\$ ' +
                                        pagamento.discount.toString() +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Valor Total: R\$ ' +
                                        pagamento.value.toString() +
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

  static _toParcelasList(
      BuildContext context, int pagamentoId, PlanModel plano) {
    NavigatorUtils.push(
      context,
      PaymentInstallmentScreen(pagamentId: pagamentoId, plano: plano),
    );
  }
}
