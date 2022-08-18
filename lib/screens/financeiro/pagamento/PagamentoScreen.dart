import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';

class PagamentoScreen {
  static pagamentoList(BuildContext context, List<PagamentoModel> pagamentos) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      alignment: Alignment.center,
      height: 300,
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
                    pagamentos.first.plano.descricao,
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
                    pagamentos.first.statusPagamento,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.blue,
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
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Preço Total: R\$ " +
                              pagamentos.first.valor.toString() +
                              "0",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Valor a ser pago: R\$ " +
                              pagamentos.first.saldo.toString() +
                              "0",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Status: " + pagamentos.first.statusPagamento,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Forma de pagamento: " +
                              pagamentos.first.tipoPagamento,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Desconto: " + pagamentos.first.desconto.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Juros a pagar: " +
                              pagamentos.first.acrescimo.toString(),
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
    );
  }
}
