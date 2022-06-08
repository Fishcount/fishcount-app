import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/email/EmailController.dart';
import 'package:fishcount_app/screens/email/EmailForm.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/screens/telefone/TelefoneController.dart';
import 'package:fishcount_app/screens/telefone/TelefoneForm.dart';
import 'package:fishcount_app/service/UsuarioService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsuarioController extends AbstractController {
  Future<dynamic> salvarUsuario(BuildContext context, String nome, String email,
      String celular, String senha) async {
    ConnectionUtils().isConnected().then((isConnected) {
      if (isConnected) {
        return saveWithApi(context, email, celular, nome, senha);
      }
      return saveLocal(context, email, celular, nome, senha);
    });
  }

  Future<dynamic> saveLocal(BuildContext context, String email, String celular,
      String nome, String senha) async {
    UsuarioModel usuario = createUsuarioModel(email, celular, nome, senha);

    return await UsuarioRepository().save(context, usuario);
  }

  Future<dynamic> saveWithApi(BuildContext context, String email,
      String celular, String nome, String senha) async {
    UsuarioModel usuario = createUsuarioModel(email, celular, nome, senha);

    dynamic response = await UsuarioService().salvarOuAtualizarUsuario(usuario);
    if (response is UsuarioModel) {
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }

  UsuarioModel createUsuarioModel(
      String email, String celular, String nome, String senha) {
    EmailModel emailModel =
        EmailModel(null, email, EnumTipoEmail.PRINCIPAL.name);
    TelefoneModel telefoneModel =
        TelefoneModel(null, celular, EnumTipoTelefone.PRINCIPAL.name);

    return UsuarioModel(null, nome, senha, [telefoneModel], [emailModel], []);
  }

  Widget resolverDadosUsuario(
      BuildContext context,
      AsyncSnapshot<List<UsuarioModel>> snapshot,
      TextEditingController _nomeController) {
    if (onHasValue(snapshot)) {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: DividerWidget(
              widgetBetween: CircleAvatar(
                maxRadius: 70,
                minRadius: 50,
                child: Image.asset(ImagePaths.imageLogo),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              thikness: 2,
              paddingRight: 10,
              paddingLeft: 10,
              height: 1,
              color: Colors.blue,
              isBold: false,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text("Nome"),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFieldWidget(
                    controller: _nomeController,
                    hintText: snapshot.data!.first.nome,
                    prefixIcon: const Icon(Icons.person),
                    focusedBorderColor: Colors.blue,
                    iconColor: Colors.black,
                    obscureText: false,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("Emails"),
                      ),
                      Container(
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(
                                Icons.add_box,
                                color: Colors.blue,
                                size: 25,
                              ),
                            ],
                          ),
                          onTap: () =>
                              NavigatorUtils.push(context, const EmailForm()),
                        ),
                      )
                    ],
                  ),
                ),
                const DividerWidget(
                  textBetween: "",
                  height: 1,
                  thikness: 1,
                  color: Colors.blueGrey,
                  paddingLeft: 0,
                  paddingRight: 0,
                  textColor: Colors.black,
                  isBold: false,
                ),
                EmailController().getEmailList(context, snapshot.data!.first.emails),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("Telefones"),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.add_box,
                              color: Colors.blue,
                              size: 25,
                            ),
                          ],
                        ),
                        onTap: () => NavigatorUtils.push(
                          context,
                          const TelefoneForm(),
                        ),
                      ),
                    )
                  ],
                ),
                const DividerWidget(
                  textBetween: "",
                  height: 1,
                  thikness: 1,
                  color: Colors.blueGrey,
                  paddingLeft: 0,
                  paddingRight: 0,
                  textColor: Colors.black,
                  isBold: false,
                ),
                TelefoneController().getPhoneList(context, snapshot.data!.first.telefones),
              ],
            ),
          ),
          ElevatedButtonWidget(
            buttonText: "Salvar",
            textColor: Colors.black,
            textSize: 20,
            radioBorder: 10,
            buttonColor: Colors.blue,
            horizontalPadding: 20,
            verticalPadding: 10,
            onPressed: () {},
          ),
        ],
      );
    }
    if (onDoneRequestWithEmptyValue(snapshot)) {
      return getNotFoundWidget(
          context, ErrorMessage.usuarioSemLote, AppPaths.cadastroUsuarioPath);
    }
    if (onError(snapshot)) {
      return getNotFoundWidget(
          context, ErrorMessage.usuarioSemLote, AppPaths.cadastroLotePath);
    }
    return const Center(child: CircularProgressIndicator());
  }
}
