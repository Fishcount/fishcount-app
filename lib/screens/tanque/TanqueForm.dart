import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/screens/tanque/TanqueController.dart';
import 'package:fishcount_app/service/EspecieService.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  String descricaoEspecie = "";
  EspecieModel? especieModel;

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
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: FutureBuilder(
                future: TanqueController().resolverListaEspecie(context),
                builder: (context, AsyncSnapshot<List<EspecieModel>> snapshot) {
                  if (TanqueController().onHasValue(snapshot)) {
                    String firstValue = snapshot.data!.first.descricao;
                    return Container(
                      height: 60,
                      alignment: Alignment.center,
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
                          value: descricaoEspecie != ""
                              ? descricaoEspecie
                              : firstValue,
                          isExpanded: true,
                          items: snapshot.data!
                              .map(
                                (especie) => DropdownMenuItem(
                                  value: especie.descricao,
                                  child: Text(especie.descricao),
                                ),
                              )
                              .toList(),
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              descricaoEspecie = novoItemSelecionado ?? "";
                            });
                          }),
                    );
                  }
                  if (TanqueController()
                      .onDoneRequestWithEmptyValue(snapshot)) {
                    return TanqueController().getNotFoundWidget(
                        context,
                        ErrorMessage.usuarioSemTanque,
                        AppPaths.cadastroTanquePath);
                  }
                  if (TanqueController().onError(snapshot)) {
                    return ErrorHandler.getDefaultErrorMessage(
                        context, ErrorMessage.serverError);
                  }
                  return Center(
                    child: TanqueController().getCircularProgressIndicator(),
                  );
                },
              ),
            ),
            descricaoEspecie == ""
                ? const Text("")
                : FutureBuilder(
                    future: EspecieService()
                        .findByDescricao(context, descricaoEspecie),
                    builder: (context, AsyncSnapshot<EspecieModel> snapshot) {
                      return TanqueController()
                          .resolverDadosEspecie(snapshot, context);
                    },
                  ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButtonWidget(
                buttonText: "Taxa de crescimento",
                buttonColor: Colors.yellow.shade600,
                radioBorder: 10,
                verticalPadding: 20,
                textColor: Colors.black,
                textSize: 20,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
