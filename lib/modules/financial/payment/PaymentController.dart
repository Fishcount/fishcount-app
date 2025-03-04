import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PlanModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';

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

  static _onEmptyResponse() => const Text(
      "Não foi possível encontrar nenhum pagamento para o seu usuário, por favor, entre em contato.");

  static _onWaitingResponse() => Container(
        padding: const EdgeInsets.only(top: 100),
        child: AnimationUtils.progressiveDots(size: 50.0),
      );

  static SingleChildScrollView _onSuccessfulRequest(
      BuildContext context, AsyncSnapshot<List<PaymentModel>> snapshot) {
    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[100];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.3
            : MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data != null ? snapshot.data!.length : 0,
          itemBuilder: (context, index) {
            final PaymentModel pagamento = snapshot.data![index];
            return GestureDetector(
              onTap: () => NavigatorUtils.pushWithFadeAnimation(
                context,
                PaymentInstallmentScreen(
                    pagamentId: pagamento.id!, plano: pagamento.plan),
              ),
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
                                        pagamento.increase
                                            .toString()
                                            .replaceAll('.', ',') +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Desconto: R\$ ' +
                                        pagamento.discount
                                            .toString()
                                            .replaceAll('.', ',') +
                                        '0',
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Valor Total: R\$ ' +
                                        pagamento.value
                                            .toString()
                                            .replaceAll('.', ',') +
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
}
