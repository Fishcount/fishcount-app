import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroScreen.dart';
import 'package:fishcount_app/service/PessoaService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinanceiroForm extends StatefulWidget {
  final PessoaModel pessoaModel;

  const FinanceiroForm({
    Key? key,
    required this.pessoaModel,
  }) : super(key: key);

  @override
  State<FinanceiroForm> createState() => _FinanceiroformState();
}

class _FinanceiroformState extends State<FinanceiroForm> {
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          children: [
            const DividerWidget(
              widgetBetween: Text(
                "Conclua seu cadastro!",
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
              height: 1,
              thikness: 1,
              color: Colors.blue,
              paddingLeft: 12,
              paddingRight: 12,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: TextFieldWidget(
                controller: _cpfController,
                hintText: "CPF",
                labelText: "Informe seu cpf",
                iconColor: Colors.blueGrey,
                obscureText: false,
                focusedBorderColor: Colors.blueGrey,
                inputMask: Formatters.cpfFormat,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButtonWidget(
                textSize: 18,
                radioBorder: 20,
                horizontalPadding: 30,
                verticalPadding: 10,
                textColor: Colors.white,
                buttonColor: Colors.blue,
                buttonText: "Salvar",
                onPressed: () async {
                  widget.pessoaModel.cpf = _cpfController.text;
                  dynamic response = await PessoaService()
                      .salvarOuAtualizarUsuario(widget.pessoaModel);

                  if (response is PessoaModel) {
                    NavigatorUtils.pushReplacement(context, const FinanceiroScreen());
                  }
                  if (response is ErrorModel) {
                    return ErrorHandler.getDefaultErrorMessage(context, response.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
