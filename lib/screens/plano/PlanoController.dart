import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanoController extends AbstractController {
  Widget listarPlanos(List<PlanoModel> planoModel, BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: planoModel.length,
          itemBuilder: (context, index) {
            PlanoModel plano = planoModel[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 150,
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
                              Text("Mínimo de tanques: " +
                                  plano.minTanque.toString()),
                              Text("Máximo de tanques: " +
                                  plano.maxTanque.toString()),
                              Text("Parcelas: " + plano.maxTanque.toString()),
                              Text("Valor máximo: R\$ " +
                                  plano.valorMaximo.toString()),
                              Text("Valor mínimo: R\$ " +
                                  plano.valorMinimo.toString()),
                              // texto
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              //botoes
                            ],
                          ),
                        )
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
}
