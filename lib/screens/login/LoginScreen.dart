import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/screens/login/LoginController.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/IconWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/buttons/TextButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _senhaController = TextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset(ImagePaths.imageLogo),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: _emailController,
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.person),
                        focusedBorderColor: Colors.blueGrey.shade100,
                        iconColor: Colors.blueGrey,
                        obscureText: false,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFieldWidget(
                          controller: _senhaController,
                          hintText: "Senha",
                          prefixIcon: const Icon(Icons.password_rounded),
                          focusedBorderColor: Colors.blueGrey.shade100,
                          iconColor: Colors.blueGrey,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButtonWidget(
                    paddingAll: 10,
                    textSize: 20,
                    radioBorder: 18,
                    buttonText: "Entrar".toUpperCase(),
                    buttonColor: Colors.yellowAccent.shade700,
                    textColor: Colors.blueGrey,
                    onPressed: () {
                      LoginController().doLogin(
                        context,
                        _emailController.text,
                        _senhaController.text,
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: const TextButtonWidget(
                    textColor: Colors.black54,
                    textSize: 20,
                    buttonText: "Criar Conta",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
                  child: const DividerWidget(
                    textBetween: "Entrar com rede social",
                    height: 10,
                    thikness: 2,
                    paddingLeft: 10,
                    paddingRight: 10,
                    color: Colors.black26,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconWidget(
                          iconColor: Colors.deepOrange.shade700,
                          icon: LineIcons.instagram,
                          iconSize: 50,
                          gestureDetectorFunction: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconWidget(
                          iconColor: Colors.blue.shade700,
                          icon: LineIcons.facebook,
                          iconSize: 50,
                          gestureDetectorFunction: () {},
                        ),
                      ),
                      IconWidget(
                        iconColor: Colors.deepOrange.shade300,
                        icon: LineIcons.googleLogo,
                        iconSize: 50,
                        gestureDetectorFunction: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
