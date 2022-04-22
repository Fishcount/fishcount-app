import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/lote/LotesController.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroLoteScreen extends StatefulWidget {
  final LoteModel? lote;

  const CadastroLoteScreen({Key? key, this.lote}) : super(key: key);

  @override
  State<CadastroLoteScreen> createState() => _CadastroLoteScreenState();
}

class _CadastroLoteScreenState extends State<CadastroLoteScreen> {
  final TextEditingController _nomeLoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nomeLoteController.text =
        widget.lote != null ? widget.lote!.descricao : "";

    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                widget.lote != null ? widget.lote!.descricao : "Novo Lote",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: TextFieldWidget(
                controller: _nomeLoteController,
                hintText: "Nome do lote",
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
                buttonText: widget.lote != null ? "Atualizar" : "Salvar",
                onPressed: () => {
                  LotesController().salvarLote(
                      context, widget.lote, _nomeLoteController.text)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
