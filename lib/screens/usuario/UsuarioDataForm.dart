import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/repository/EmailRepository.dart';
import 'package:fishcount_app/repository/TelefoneRepository.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/email/EmailForm.dart';
import 'package:fishcount_app/screens/telefone/TelefoneForm.dart';
import 'package:fishcount_app/screens/usuario/UsuarioController.dart';
import 'package:fishcount_app/service/PessoaService.dart';
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

  Future<List<PessoaModel>> buscarUsuario() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return PessoaService().buscarPessoa();
    }
    return UsuarioRepository().buscarUsuario(context);
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
            builder: (context, AsyncSnapshot<List<PessoaModel>> snapshot) {
              return UsuarioController().resolverDadosUsuario(context, snapshot, _nomeController);
            },
          ),
        ),
      ),
    );
  }
}
