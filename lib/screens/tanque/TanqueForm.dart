import 'package:fishcount_app/model/TanqueModel.dart';
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
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                widget.tanque != null
                    ? widget.tanque!.descricao
                    : "Novo Tanque",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
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
              padding: const EdgeInsets.only(top: 40),
              child: ElevatedButtonWidget(
                textSize: 18,
                radioBorder: 20,
                horizontalPadding: 30,
                verticalPadding: 10,
                textColor: Colors.white,
                buttonColor: Colors.blue,
                buttonText: widget.tanque != null ? "Atualizar" : "Salvar",
                onPressed: () => {
                  // LotesController().salvarLote(
                  //     context, widget.lote, _nomeLoteController.text)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
