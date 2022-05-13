import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/screens/usuario/UsuarioService.dart';
import 'package:flutter/cupertino.dart';

class UsuarioDataForm extends StatefulWidget {
  const UsuarioDataForm({Key? key}) : super(key: key);

  @override
  State<UsuarioDataForm> createState() => _UsuarioDataFormState();
}

class _UsuarioDataFormState extends State<UsuarioDataForm> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UsuarioService().buscarUsuario(),
        builder: (context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
          return Text("teste");
        });
  }
}
