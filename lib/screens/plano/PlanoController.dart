import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
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
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Mínimo de tanques: " +
                                      plano.minTanque.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "Máximo de tanques: " +
                                      plano.maxTanque.toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                    "Parcelas: " + plano.maxTanque.toString(),
                                  style: TextStyle(fontSize: 15),
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
                                onPressed: () {},
                              ),
                              ElevatedButtonWidget(
                                buttonText: "Entrar em contato",
                                buttonColor: Colors.white,
                                radioBorder: 3,
                                textSize: 17,
                                textColor: Colors.grey,
                                onPressed: () {},
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
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Valor total do plano: R\$ " +
                                plano.valorMinimo.toString(),
                            style: TextStyle(
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
}
