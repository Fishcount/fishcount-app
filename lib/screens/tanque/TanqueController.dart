import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/screens/AbstractController.dart';
import 'package:fishcount_app/screens/tanque/CadastroTanqueScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/TanqueModel.dart';

class TanqueController extends AbstractController {
  Widget resolverListaLotes(
      BuildContext context, AsyncSnapshot<List<TanqueModel>> snapshot) {
    if (onHasValue(snapshot)) {}
    if (onDoneRequestWithEmptyValue(snapshot)) {
      return getNotFoundWidget(context, ExceptionsMessage.usuarioSemTanque,
          AppPaths.cadastroTanquePath);
    }
    if (onError(snapshot)) {
      return getDefaultErrorMessage(context, ExceptionsMessage.serverError);
    }
    return getCircularProgressIndicator();
  }

  Widget _listaTanques(BuildContext context, List<TanqueModel> tanques) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanques.length,
          itemBuilder: (context, index) {
            TanqueModel tanque = tanques[index];
            return Container(
              margin: const EdgeInsets.only(top: 10),
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black26),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getEditIcon(context, CadastroTanqueScreen()),
                  getDescricao(
                      context, CadastroTanqueScreen(), tanque.descricao),
                  getTrashIcon()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
