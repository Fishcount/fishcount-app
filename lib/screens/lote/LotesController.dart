import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/AbstractController.dart';
import 'package:fishcount_app/screens/lote/CadastroLoteScreen.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/screens/lote/LotesService.dart';
import 'package:flutter/material.dart';

import '../../constants/exceptions/ExceptionsMessage.dart';

class LotesController extends AbstractController {
  Future<dynamic> salvarLote(
      BuildContext context, LoteModel? managedLote, String nomeLote) async {
    if (managedLote != null) {
      managedLote.descricao = nomeLote;
      return resolverSalvarOrAtualizar(context, managedLote);
    }
    return resolverSalvarOrAtualizar(context, LoteModel(null, nomeLote));
  }

  Future<dynamic> resolverSalvarOrAtualizar(
      BuildContext context, LoteModel managedLote) async {
    dynamic response = await LotesService().salvarOrAtualizarLote(managedLote);

    if (response is LoteModel) {
      pushReplacement(context, const LotesScreen());
    }
    if (response is ErrorModel) {
      return getDefaultErrorMessage(context, response);
    }
  }

  Widget resolverListaLotes(
      BuildContext context, AsyncSnapshot<List<LoteModel>> snapshot) {
    if (onHasValue(snapshot)) {
      return _listaLotes(context, snapshot.data!);
    }
    if (onDoneRequestWithEmptyValue(snapshot)) {
      return getNotFoundWidget(
          context, ExceptionsMessage.usuarioSemLote, AppPaths.cadastroLotePath);
    }
    if (onError(snapshot)) {
      return getDefaultErrorMessage(context, ExceptionsMessage.serverError);
    }
    return getCircularProgressIndicator();
  }

  Widget _listaLotes(BuildContext context, List<LoteModel> lotes) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lotes.length,
          itemBuilder: (context, index) {
            LoteModel lote = lotes[index];
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
                  getEditIcon(context, CadastroLoteScreen(lote: lote)),
                  getDescricao(
                      context, CadastroLoteScreen(lote: lote), lote.descricao),
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
