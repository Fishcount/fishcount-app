import 'package:fishcount_app/constants/Formatters.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarBuilder().build(),
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
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButtonWidget(
                  textSize: 18,
                  radioBorder: 20,
                  horizontalPadding: 30,
                  verticalPadding: 10,
                  textColor: Colors.white,
                  buttonColor: Colors.blue,
                  buttonText: "Salvar",
                  onPressed: () {
                    PessoaController().salvar(
                        context,
                        _nomeController.text,
                        _emailController.text,
                        _telefoneController.text,
                        _senhaController.text);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
