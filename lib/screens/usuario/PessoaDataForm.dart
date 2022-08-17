import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/screens/lote/LoteForm.dart';
import 'package:fishcount_app/screens/usuario/PessoaController.dart';
import 'package:fishcount_app/service/PessoaService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PessoaDataForm extends StatefulWidget {
  const PessoaDataForm({Key? key}) : super(key: key);

  @override
  State<PessoaDataForm> createState() => _PessoaDataFormState();
}

class _PessoaDataFormState extends State<PessoaDataForm> {
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
          CustomBottomSheet.getCustomBottomSheet(context, const LoteForm()),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: FutureBuilder(
            future: buscarUsuario(),
            builder: (context, AsyncSnapshot<List<PessoaModel>> snapshot) {
              return PessoaController().resolverDadosUsuario(context, snapshot, _nomeController);
            },
          ),
        ),
      ),
    );
  }
}
