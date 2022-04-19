import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CadastroLoteScreen extends StatefulWidget {
  const CadastroLoteScreen({Key? key}) : super(key: key);

  @override
  State<CadastroLoteScreen> createState() => _CadastroLoteScreenState();
}

class _CadastroLoteScreenState extends State<CadastroLoteScreen> {
  TextEditingController _nomeLoteController = TextEditingController();
  TextEditingController _localLoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      // bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(context),
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                "Novo Lote",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              padding: const EdgeInsets.only(top: 20),
              child: TextFieldWidget(
                controller: _nomeLoteController,
                hintText: "Local do lote",
                prefixIcon: const Icon(Icons.place),
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
                buttonText: "Salvar",
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
