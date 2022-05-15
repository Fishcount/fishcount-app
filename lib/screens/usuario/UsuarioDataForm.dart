import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/email/EmailForm.dart';
import 'package:fishcount_app/service/UsuarioService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
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
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: FutureBuilder(
            future: buscarUsuario(),
            builder: (context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        maxRadius: 70,
                        minRadius: 50,
                        child: Image.asset(ImagePaths.imageLogo),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text("Nome"),
                          ),
                          TextFieldWidget(
                            controller: _nomeController,
                            hintText: snapshot.data!.first.nome,
                            prefixIcon: const Icon(Icons.person),
                            focusedBorderColor: Colors.blue,
                            iconColor: Colors.black,
                            obscureText: false,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: const Text("Emails"),
                          ),
                          FutureBuilder(
                            future: buscarEmails(),
                            builder: (context,
                                AsyncSnapshot<List<EmailModel>> snapshot) {
                              if (snapshot.hasData) {
                                return getSelectEmails(snapshot, context);
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: const Text("Telefones"),
                          ),
                          FutureBuilder(
                            future: buscarTelefones(),
                            builder: (context,
                                AsyncSnapshot<List<TelefoneModel>> snapshot) {
                              if (snapshot.hasData) {
                                return getSelectTelefones(snapshot, context);
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  DropdownButton<EmailModel> getSelectEmails(
      AsyncSnapshot<List<EmailModel>> snapshot, BuildContext context) {
    return DropdownButton<EmailModel>(
      isExpanded: true,
      iconSize: 0,
      alignment: Alignment.centerLeft,
      value: snapshot.data!.first,
      borderRadius: BorderRadius.circular(20),
      items: snapshot.data!.map<DropdownMenuItem<EmailModel>>((email) {
        return DropdownMenuItem<EmailModel>(
          value: email,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(email.descricao, overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(email.tipoEmail),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      NavigatorUtils.pushReplacement(context, EmailForm(emailId: email.id,));
                    },
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onTap: () {
                     NavigatorUtils.pushReplacement(context, const EmailForm());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (TelefoneModel) {},
    );
  }

  DropdownButton<TelefoneModel> getSelectTelefones(
      AsyncSnapshot<List<TelefoneModel>> snapshot, BuildContext context) {
    return DropdownButton<TelefoneModel>(
      isExpanded: true,
      iconSize: 0,
      alignment: Alignment.centerLeft,
      value: snapshot.data!.first,
      borderRadius: BorderRadius.circular(20),
      items: snapshot.data!.map<DropdownMenuItem<TelefoneModel>>((telefone) {
        return DropdownMenuItem<TelefoneModel>(
          value: telefone,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 170,
                          child: Text(telefone.descricao),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(telefone.tipoTelefone),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () {
                      print("editar telefone");
                    },
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onTap: () {
                      print("adicionar telefone");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (TelefoneModel) {},
    );
  }
}
