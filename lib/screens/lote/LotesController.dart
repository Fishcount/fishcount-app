import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/lote/LoteForm.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/service/LotesService.dart';
import 'package:fishcount_app/screens/tanque/TanqueScreen.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/exceptions/ExceptionsMessage.dart';

class LotesController extends AbstractController {
  Future<dynamic> salvarLote(
      BuildContext context, LoteModel? managedLote, String nomeLote) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return saveWithApi(managedLote, nomeLote, context);
    }
    return saveLocal(managedLote, nomeLote, context);
  }

  Future<dynamic> saveLocal(
      LoteModel? managedLote, String nomeLote, BuildContext context) async {
    LoteModel lote = LoteModel(null, nomeLote, null);

    return LoteRepository().save(context, lote);
  }

  Future<dynamic> saveWithApi(
      LoteModel? managedLote, String nomeLote, BuildContext context) {
    if (managedLote != null) {
      managedLote.descricao = nomeLote;
      return resolverSalvarOrAtualizar(context, managedLote);
    }
    return resolverSalvarOrAtualizar(context, LoteModel(null, nomeLote, null));
  }

  Future<dynamic> resolverSalvarOrAtualizar(
      BuildContext context, LoteModel managedLote) async {
    dynamic response = await LotesService().salvarOrAtualizarLote(managedLote);

    if (response is LoteModel) {
      NavigatorUtils.pushReplacement(context, const LotesScreen());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
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
      return getNotFoundWidget(
          context, ExceptionsMessage.usuarioSemLote, AppPaths.cadastroLotePath);
    }
    return getCircularProgressIndicator();
  }

  Widget getQtdeLote(BuildContext context, String text) {
    return FutureBuilder(
        future: LotesService().listarLotesUsuario(),
        builder: (context, AsyncSnapshot<List<LoteModel>> snapshot) {
          if (onHasValue(snapshot)) {
            String controller = snapshot.data!.length > 1 ? "s" : "";
            return Text(snapshot.data!.length.toString() + " $text$controller");
          }
          if (onDoneRequestWithEmptyValue(snapshot)) {
            return Text("0 $text");
          }
          if (onError(snapshot)) {
            return ErrorHandler.getDefaultErrorMessage(
                context, ExceptionsMessage.serverError);
          }
          return const Text("");
        });
  }

  Widget _listaLotes(BuildContext context, List<LoteModel> lotes) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: lotes.length,
          itemBuilder: (context, index) {
            LoteModel lote = lotes[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 70,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Colors.black26,
                  ),
                  right: BorderSide(
                    color: Colors.black26,
                  ),
                  top: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            NavigatorUtils.pushReplacement(
                              context,
                              TanquesScreen(
                                lote: lote,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              lote.descricao.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            lote.tanques != null ? lote.tanques!.length.toString() + " Tanques" : "0 tanques",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 7,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                          onTap: () {
                            NavigatorUtils.push(
                              context,
                              LoteForm(
                                lote: lote,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 6,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.trash,
                            color: Colors.red,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
