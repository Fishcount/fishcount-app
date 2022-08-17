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
        padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
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
                          "Preço Total: R\$ " + pagamentos.first.valor.toString() + "0",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Valor a ser pago: R\$ " +
                              pagamentos.first.saldo.toString() + "0",
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
                          "Forma de pagamento: " + pagamentos.first.tipoPagamento,
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
                          "Juros a pagar: " + pagamentos.first.acrescimo.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(left: 20),
                      //   alignment: Alignment.center,
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.only(top: 20, right: 10),
                      //         child: ElevatedButtonWidget(
                      //           buttonText: "dsfaeo",
                      //           buttonColor: Colors.white,
                      //           radioBorder: 3,
                      //           textSize: 17,
                      //           textColor: Colors.grey,
                      //           onPressed: () {},
                      //         ),
                      //       ),
                      //       Container(
                      //         padding: EdgeInsets.only(top: 20, right: 10),
                      //         child: ElevatedButtonWidget(
                      //           buttonText: "Asadsjá",
                      //           buttonColor: Colors.blue,
                      //           radioBorder: 10,
                      //           textSize: 17,
                      //           textColor: Colors.white,
                      //           onPressed: () {},
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.only(top: 20),
    //   child: Column(
    //     children: [
    //       Container(
    //         padding:
    //             const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    //         decoration: const BoxDecoration(
    //           color: Colors.grey,
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(7),
    //           ),
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             const Text("Mês"),
    //             const Text("|"),
    //             const Text("Vencimento"),
    //             const Text("|"),
    //             Container(
    //               padding: const EdgeInsets.only(left: 10, right: 10),
    //               child: const Text("Valor"),
    //             ),
    //             const Text("|"),
    //             const Text("Status"),
    //           ],
    //         ),
    //       ),
    //       SingleChildScrollView(
    //         child: Container(
    //           padding: const EdgeInsets.only(top: 20),
    //           height: MediaQuery.of(context).size.height / 1.4,
    //           child: ListView.builder(
    //             itemCount: pagamentos.length,
    //             itemBuilder: (BuildContext context, index) {
    //               return Container(
    //                 decoration: const BoxDecoration(
    //                     border: Border(
    //                   top: BorderSide(color: Colors.black26, width: 1),
    //                   right: BorderSide(color: Colors.black26, width: 1),
    //                   left: BorderSide(color: Colors.black26, width: 1),
    //                   bottom: BorderSide(color: Colors.blueAccent, width: 2),
    //                 )),
    //                 margin: const EdgeInsets.only(bottom: 15),
    //                 child: ListTile(
    //                   // leading: Text("DEZ"),
    //                   trailing: Text(
    //                     pagamentos[index].statusPagamento,
    //                     style: const TextStyle(
    //                       color: Colors.green,
    //                       fontSize: 15,
    //                     ),
    //                   ),
    //                   title: Container(
    //                     padding: const EdgeInsets.all(10),
    //                     child: Row(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: const [
    //                         Text("Dez"),
    //                         Text("|"),
    //                         Text("01/01/2021"),
    //                         Text("|"),
    //                         Text("Valor"),
    //                         Text("|"),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
