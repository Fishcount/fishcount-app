import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  const CadastroUsuarioScreen({Key? key}) : super(key: key);

  @override
  State<CadastroUsuarioScreen> createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
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
                  controller: _emailController,
                  hintText: "Digite seu email",
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
                  hintText: "Digite seu telefone",
                  prefixIcon: const Icon(Icons.phone_android),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _cpfController,
                  hintText: "Digite seu Cpf",
                  prefixIcon: const Icon(Icons.perm_identity_sharp),
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                  focusedBorderColor: Colors.blueGrey,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _senhaController,
                  hintText: "Digite uma senha",
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
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
