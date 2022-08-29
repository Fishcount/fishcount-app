import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/modules/batch/BatchController.dart';
import 'package:fishcount_app/repository/UsuarioRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../batch/BatchForm.dart';
import 'PessoaController.dart';
import 'PessoaService.dart';

class PessoaDataForm extends StatefulWidget {
  const PessoaDataForm({Key? key}) : super(key: key);

  @override
  State<PessoaDataForm> createState() => _PessoaDataFormState();
}

class _PessoaDataFormState extends State<PessoaDataForm> 
    with TickerProviderStateMixin {
  final TextEditingController _nomeController = TextEditingController();
  final BatchController _batchController = BatchController();
  late AnimationController _animationController;

  @override
  initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 1);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<PersonModel?> buscarUsuario() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return PersonService().findById();
    }
    return UsuarioRepository().buscarUsuario(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
        context,
        () => _batchController.openBatchRegisterModal(
            context, TextEditingController(), _animationController, null),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: FutureBuilder(
            future: buscarUsuario(),
            builder: (context, AsyncSnapshot<PersonModel?> snapshot) {
              return PessoaController()
                  .resolverDadosUsuario(context, snapshot, _nomeController);
            },
          ),
        ),
      ),
    );
  }
}
