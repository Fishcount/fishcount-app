import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/email/EmailForm.dart';
import 'package:fishcount_app/screens/telefone/TelefoneForm.dart';
import 'package:fishcount_app/service/UsuarioService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/ItemContainerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsuarioDataForm extends StatefulWidget {
  const UsuarioDataForm({Key? key}) : super(key: key);

  @override
  State<UsuarioDataForm> createState() => _UsuarioDataFormState();
}

class _UsuarioDataFormState extends State<UsuarioDataForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  Future<List<UsuarioModel>> buscarUsuario() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return UsuarioService().buscarUsuario();
    }
    return UsuarioRepository().buscarUsuario(context);
  }

  Future<List<TelefoneModel>> buscarTelefones() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("buscar na api");
    }
    return TelefoneRepository().listarTelefones(context);
  }

  Future<List<EmailModel>> buscarEmails() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("buscar na api");
    }
    return EmailRepository().listarEmails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      bottomNavigationBar:
          CustomBottomSheet.getCustomBottomSheet(context, AppPaths.lotesPath),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: FutureBuilder(
            future: buscarUsuario(),
            builder: (context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
              if (snapshot.hasData) {
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
                        )),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Icon(
                                          Icons.add_box,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ],
                                    ),
                                    onTap: () => NavigatorUtils.push(
                                        context, const EmailForm()),
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
                              isBold: false),
                          _getEmailList(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                              isBold: false),
                          _getPhoneList(),
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
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<EmailModel>> _getEmailList() {
    return FutureBuilder(
        future: buscarEmails(),
        builder: (context, AsyncSnapshot<List<EmailModel>> snapshot) {
          if (snapshot.hasData) {
            return _getEmailItem(snapshot);
          }
          return const CircularProgressIndicator();
        });
  }

  Container _getEmailItem(AsyncSnapshot<List<EmailModel>> snapshot) {
    return Container(
            height: 120,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                EmailModel email = snapshot.data![index];
                return ItemContainerWidget(
                  titles: email.descricao,
                  subTitles: email.tipoEmail,
                  prefixIcon: const Icon(Icons.email),
                  onChange: () => NavigatorUtils.push(
                    context,
                    EmailForm(
                      emailModel: email,
                    ),
                  ),
                  onDelete: () {},
                );
              },
            ),
          );
  }

  FutureBuilder<List<TelefoneModel>> _getPhoneList() {
    return FutureBuilder(
      future: buscarTelefones(),
      builder: (context, AsyncSnapshot<List<TelefoneModel>> snapshot) {
        if (snapshot.hasData) {
          return _getTelefoneItem(
            snapshot.data!.length,
            snapshot.data!,
            () => NavigatorUtils.push(context, const TelefoneForm()),
            () {},
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Container _getTelefoneItem(int itemCount, List<TelefoneModel> telefones,
      Function() onChange, Function() onDelete) {
    return Container(
      height: 120,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ItemContainerWidget(
            titles: telefones[index].descricao,
            subTitles: telefones[index].tipoTelefone,
            prefixIcon: const Icon(Icons.phone_android),
            onChange: () => NavigatorUtils.push(
              context,
              TelefoneForm(telefoneModel: telefones[index]),
            ),
            onDelete: onDelete,
          );
        },
      ),
    );
  }
}
