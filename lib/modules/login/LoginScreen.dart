import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/modules/batch/BatchScreen.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/IconWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/buttons/TextButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'LoginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppPaths.lotesPath);
                    },
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(ImagePaths.imageLogo),
                    ),
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
                          prefixIcon: const Icon(Icons.lock),
                          focusedBorderColor: Colors.blueGrey.shade100,
                          iconColor: Colors.blueGrey,
                          obscureText: true,
                          isPassword: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: loading
                      ? Container(
                          child: LoadingAnimationWidget.prograssiveDots(
                              color: Colors.blue, size: 40.0),
                        )
                      : ElevatedButtonWidget(
                          textSize: 18,
                          radioBorder: 20,
                          horizontalPadding: 30,
                          verticalPadding: 10,
                          textColor: Colors.white,
                          buttonColor: Colors.blue,
                          paddingAll: 10,
                          buttonText: "Entrar".toUpperCase(),
                          onPressed: () async {
                            setState(() => loading = true);
                            dynamic result = await LoginController().doLogin(
                              context,
                              _emailController.text,
                              _senhaController.text,
                            );
                            if (result is ScaffoldFeatureController) {
                              setState(() => loading = false);
                              return result;
                            }
                            if (result is bool) {
                              NavigatorUtils.pushReplacement(
                                  context, const BatchScreen());
                            }
                          },
                        ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: TextButtonWidget(
                    textColor: Colors.black54,
                    textSize: 20,
                    buttonText: "Criar Conta".toUpperCase(),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppPaths.cadastroUsuarioPath);
                    },
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
                    textColor: Colors.black26,
                    isBold: false,
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
                        iconColor: Colors.amber.shade700,
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
