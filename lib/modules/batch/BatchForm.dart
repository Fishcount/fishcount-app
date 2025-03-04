import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BatchController.dart';

class BatchForm extends StatefulWidget {
  final BatchModel? lote;

  const BatchForm({Key? key, this.lote}) : super(key: key);

  @override
  State<BatchForm> createState() => _BatchFormState();
}

class _BatchFormState extends State<BatchForm> {
  final TextEditingController _nomeLoteController = TextEditingController();
  final BatchController _batchController = BatchController();

  @override
  Widget build(BuildContext context) {
    _nomeLoteController.text =
        widget.lote != null ? widget.lote!.description : "";

    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                widget.lote != null ? widget.lote!.description : "Novo Lote",
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
                onPressed: () => _batchController.saveBatch(
                    context, _nomeLoteController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
