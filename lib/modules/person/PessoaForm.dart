import 'package:fishcount_app/constants/Formatters.dart';

import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

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
      appBar: CustomAppBar.build(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: const Text(
                  "Novo Usuário!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: TextFieldWidget(
                  controller: _nomeController,
                  hintText: "Nome",
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
                  prefixIcon: const Icon(Icons.phone_android),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                  inputMask: Formatters.phoneMask,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _senhaController,
                  hintText: "Senha",
                  prefixIcon: const Icon(Icons.password_rounded),
                  iconColor: Colors.blueGrey,
                  focusedBorderColor: Colors.blueGrey,
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
