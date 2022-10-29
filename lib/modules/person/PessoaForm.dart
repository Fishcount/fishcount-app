import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/modules/batch/BatchScreen.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/PersonModel.dart';
import '../../utils/NavigatorUtils.dart';
import 'PessoaController.dart';

class PessoaForm extends StatefulWidget {
  const PessoaForm({Key? key}) : super(key: key);

  @override
  State<PessoaForm> createState() => _PessoaFormState();
}

class _PessoaFormState extends State<PessoaForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final PessoaController _pessoaController = PessoaController();
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: const DividerWidget(
                  height: 1,
                  thikness: 1,
                  color: Colors.grey,
                  paddingLeft: 10,
                  paddingRight: 10,
                  widgetBetween: Text(
                    'Cadastre-se!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: TextFieldWidget(
                  controller: _nomeController,
                  hintText: "Nome",
                  labelText: "Digite seu nome",
                  prefixIcon: const Icon(Icons.person),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                  errorText: resolveErrorText(
                    submitted: _submitted,
                    controller: _nomeController,
                    errorMessage: 'O campo nome não pode estar vazio.',
                  ),
                  onChanged: (text) => setState(
                    () => resolveOnChaged(_nomeController, _submitted, text),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _emailController,
                  hintText: "Email",
                  labelText: "Digite seu email",
                  prefixIcon: const Icon(Icons.email),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                  errorText: resolveErrorText(
                    submitted: _submitted,
                    controller: _emailController,
                    errorMessage: 'O campo email não pode estar vazio.',
                  ),
                  onChanged: (text) => setState(
                    () => resolveOnChaged(_emailController, _submitted, text),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _telefoneController,
                  hintText: "Celular",
                  labelText: "Digite seu celular",
                  prefixIcon: const Icon(Icons.phone_android),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                  keyBoardType: TextInputType.number,
                  inputMask: Formatters.phoneMask,
                  errorText: resolveErrorText(
                    submitted: _submitted,
                    controller: _telefoneController,
                    errorMessage: 'O campo telefone não pode estar vazio.',
                  ),
                  onChanged: (text) => setState(
                    () =>
                        resolveOnChaged(_telefoneController, _submitted, text),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _senhaController,
                  hintText: "Senha",
                  labelText: "Digite sua senha",
                  prefixIcon: const Icon(Icons.password_rounded),
                  iconColor: Colors.blueGrey,
                  focusedBorderColor: Colors.blueGrey,
                  isPassword: true,
                  obscureText: true,
                  errorText: resolveErrorText(
                    submitted: _submitted,
                    controller: _senhaController,
                    errorMessage: 'O campo senha não pode estar vazio.',
                  ),
                  onChanged: (text) => setState(
                    () => resolveOnChaged(_senhaController, _submitted, text),
                  ),
                ),
              ),
              loading
                  ? Container(
                      padding: EdgeInsets.only(top: 50),
                      child: AnimationUtils.progressiveDots(size: 50.0),
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 50),
                      child: ElevatedButtonWidget(
                        textSize: 18,
                        radioBorder: 20,
                        horizontalPadding: 30,
                        verticalPadding: 10,
                        textColor: Colors.white,
                        buttonColor: Colors.blue,
                        buttonText: "Salvar",
                        onPressed: () async {
                          setState(() => _submitted = true);
                          if (_nomeController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _telefoneController.text.isEmpty ||
                              _senhaController.text.isEmpty) {
                            return;
                          }
                          setState(() => loading = true);
                          dynamic result = await _pessoaController.salvar(
                              context,
                              _nomeController.text,
                              _emailController.text,
                              _telefoneController.text,
                              _senhaController.text);
                          if (result is PersonModel) {
                            NavigatorUtils.pushReplacement(
                                context, const BatchScreen());
                          }
                          if (result is ScaffoldFeatureController) {
                            setState(() => loading = false);
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
