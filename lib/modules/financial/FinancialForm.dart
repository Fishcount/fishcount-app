import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../person/PessoaService.dart';
import 'FinancialScreen.dart';

class FinancialForm extends StatefulWidget {
  final PersonModel? pessoaModel;

  const FinancialForm({
    Key? key,
    this.pessoaModel,
  }) : super(key: key);

  @override
  State<FinancialForm> createState() => _FinanceiroformState();
}

class _FinanceiroformState extends State<FinancialForm> {
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
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
                  if (widget.pessoaModel == null) {
                    return Text("");
                  }
                  widget.pessoaModel!.cpf = _cpfController.text;
                  dynamic response = await PersonService()
                      .saveOrUpdate(widget.pessoaModel!);

                  if (response is PersonModel) {
                    NavigatorUtils.pushReplacement(
                        context, const FinancialScreen());
                  }
                  if (response is ErrorModel) {
                    return ErrorHandler.getDefaultErrorMessage(
                        context, response.message);
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
