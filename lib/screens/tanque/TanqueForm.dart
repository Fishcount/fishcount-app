import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/repository/EspecieRepository.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TanqueForm extends StatefulWidget {
  final TanqueModel? tanque;

  const TanqueForm({
    Key? key,
    this.tanque,
  }) : super(key: key);

  @override
  State<TanqueForm> createState() => _TanqueFormState();
}

class _TanqueFormState extends State<TanqueForm> {
  final TextEditingController _nomeTanqueController = TextEditingController();

  List<String> especies = ["especie 1", "especie 2"];

  String especieSelecionada = "especie 1";

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nomeTanqueController.text =
        widget.tanque != null ? widget.tanque!.descricao : "";
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                widget.tanque != null
                    ? widget.tanque!.descricao
                    : "Novo Tanque",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFieldWidget(
                controller: _nomeTanqueController,
                hintText: "Nome do Tanque",
                prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                focusedBorderColor: Colors.blueGrey,
                iconColor: Colors.blueGrey,
                obscureText: false,
              ),
            ),
            FutureBuilder(
              future: EspecieRepository().listar(context),
              builder: (context, AsyncSnapshot<List<EspecieModel>> snapshot) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(232, 232, 232, 232),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<String>(
                      value: snapshot.data!.first.descricao,
                      isExpanded: true,
                      items: snapshot.data!.map(
                        (especie) {
                          return DropdownMenuItem(
                            value: especie.descricao,
                            child: Container(
                              child: Text(especie.descricao),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? novoItemSelecionado) {}),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 160,
                        height: 200,
                        child: Image.asset(ImagePaths.imageLogo),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFieldWidget(
                                controller: _controller,
                                hintText: "Peso Médio",
                                prefixIcon: const Icon(Icons.monitor_weight),
                                focusedBorderColor: Colors.blue,
                                iconColor: Colors.blue,
                                obscureText: false,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: 200,
                                child: TextFieldWidget(
                                  controller: _controller,
                                  hintText: "Tamanho médio",
                                  prefixIcon: const Icon(LineIcons.signal),
                                  focusedBorderColor: Colors.blue,
                                  iconColor: Colors.blue,
                                  obscureText: false,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: SizedBox(
                                width: 200,
                                child: TextFieldWidget(
                                  controller: _controller,
                                  hintText: "Ração",
                                  prefixIcon: const Icon(LineIcons.signal),
                                  focusedBorderColor: Colors.blue,
                                  iconColor: Colors.blue,
                                  obscureText: false,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      "Texa de Crescimento",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextFieldWidget(
                      controller: _controller,
                      hintText: "Quantidade de aumento",
                      prefixIcon: const Icon(LineIcons.signal),
                      focusedBorderColor: Colors.blue,
                      iconColor: Colors.blue,
                      obscureText: false,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextFieldWidget(
                      controller: _controller,
                      hintText: "Intervalo de aumento",
                      prefixIcon: const Icon(LineIcons.addressBookAlt),
                      focusedBorderColor: Colors.blue,
                      iconColor: Colors.blue,
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 35),
              child: ElevatedButtonWidget(
                textSize: 18,
                radioBorder: 20,
                horizontalPadding: 30,
                verticalPadding: 10,
                textColor: Colors.white,
                buttonColor: Colors.blue,
                buttonText: widget.tanque != null ? "Atualizar" : "Salvar",
                onPressed: () => {
                  // TanqueController().onError()
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
