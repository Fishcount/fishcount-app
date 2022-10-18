import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
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

  bool loading = false;

  String resolveOnChaged(
      TextEditingController _controller, bool _submitted, String text) {
    return _controller.text.isEmpty && _submitted
        ? _controller.text = text
        : _controller.text;
  }

  String? resolveErrorText({
    controller = TextEditingController,
    submitted = bool,
    errorMessage = String,
  }) {
    return controller.text.isEmpty && submitted ? errorMessage : null;
  }

  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
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
              padding: const EdgeInsets.only(top: 30),
              child: TextFieldWidget(
                controller: _cpfController,
                hintText: "CPF",
                labelText: "Informe seu cpf",
                iconColor: Colors.blueGrey,
                obscureText: false,
                focusedBorderColor: Colors.blueGrey,
                inputMask: Formatters.cpfFormat,
                errorText: resolveErrorText(
                  submitted: _submitted,
                  controller: _cpfController,
                  errorMessage: 'O campo nome não pode estar vazio.',
                ),
                onChanged: (text) => setState(
                      () => resolveOnChaged(_cpfController, _submitted, text),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: loading
                  ? AnimationUtils.progressiveDots(size: 50.0)
                  : ElevatedButtonWidget(
                      textSize: 18,
                      radioBorder: 20,
                      horizontalPadding: 30,
                      verticalPadding: 10,
                      textColor: Colors.white,
                      buttonColor: Colors.blue,
                      buttonText: "Salvar",
                      onPressed: () async {
                        setState(() => _submitted = true);
                        if (_cpfController.text.isEmpty) {
                          return;
                        }
                        setState(() => loading = true);
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
                          setState(() => loading = false);
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
