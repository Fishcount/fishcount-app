import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';
import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../email/EmailController.dart';
import '../email/EmailForm.dart';
import '../generic/AbstractController.dart';
import '../phone/PhoneController.dart';
import '../phone/PhoneForm.dart';
import 'PessoaService.dart';

class PessoaController extends AbstractController {
  UsuarioRepository _usuarioRepository = UsuarioRepository();

  dynamic salvar(BuildContext context, String nome, String email,
      String celular, String senha) async {
    bool isConnected = await ConnectionUtils().isConnected();

    if (isConnected) {
      return await saveWithApi(context, email, celular, nome, senha);
    }
    return await saveLocal(context, email, celular, nome, senha);
  }

  Future<dynamic> saveLocal(BuildContext context, String email, String celular,
      String nome, String senha) async {
    PersonModel usuario = _createPessoaModel(email, celular, nome, senha);

    return await _usuarioRepository.save(context, usuario);
  }

  Future<dynamic> saveWithApi(BuildContext context, String email,
      String celular, String nome, String senha) async {
    PersonModel pessoa = _createPessoaModel(email, celular, nome, senha);

    dynamic response = await PersonService().saveOrUpdate(pessoa);
    if (response is PersonModel) {
      return response;
    }
    if (response is ErrorModel) {
      return ErrorHandler.getSnackBarError(context, response.message);
    }
  }

  PersonModel _createPessoaModel(
      String email, String celular, String nome, String senha) {
    EmailModel emailModel =
        EmailModel(null, email, EnumTipoEmail.PRINCIPAL.name);
    PhoneModel telefoneModel =
        PhoneModel(null, celular, EnumTipoTelefone.PRINCIPAL.name);

    return PersonModel(null, nome, senha, null, [telefoneModel], [emailModel], [], []);
  }

  Widget resolverDadosUsuario(
      BuildContext context,
      AsyncSnapshot<PersonModel?> snapshot,
      TextEditingController _nomeController) {
    if (onHasValue(snapshot)) {
      return Column(
        children: [
          GestureDetector(
            child: Container(
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
            // onTap: ,
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
                    hintText: snapshot.data!.name,
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
                      GestureDetector(
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
                            NavigatorUtils.pushWithFadeAnimation(context, const EmailForm()),
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
                EmailController().getEmailList(context, snapshot.data!.emails),
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
                        onTap: () => NavigatorUtils.pushWithFadeAnimation(
                          context,
                          const PhoneForm(),
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
                PhoneController().getPhoneList(context, snapshot.data!.phones),
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
      return notFoundWidgetRedirect(
          context, ErrorMessage.usuarioSemLote, AppPaths.cadastroUsuarioPath);
    }
    if (onError(snapshot)) {
      return notFoundWidgetRedirect(
          context, ErrorMessage.usuarioSemLote, AppPaths.cadastroLotePath);
    }
    return const Center(child: CircularProgressIndicator());
  }
}
