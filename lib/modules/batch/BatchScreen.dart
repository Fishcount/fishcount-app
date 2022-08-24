import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../constants/AppPaths.dart';
import '../../constants/exceptions/ErrorMessage.dart';
import '../../utils/NavigatorUtils.dart';
import '../tank/TankScreen.dart';
import 'BatchForm.dart';
import 'BatchController.dart';
import 'BatchService.dart';

class BatchScreen extends StatefulWidget {
  final AuthUserModel? authUserModel;

  const BatchScreen({Key? key, this.authUserModel}) : super(key: key);

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<BatchModel> lotes = [];

  Future<List<BatchModel>>? listarLotes(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return BatchService().fetchBatches();
    }
    return LoteRepository().listarLotesUsuario(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar:
          CustomBottomSheet.getCustomBottomSheet(context, const BatchForm()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            TextFieldWidget(
              controller: _pesquisaController,
              focusedBorderColor: Colors.white30,
              iconColor: Colors.blueGrey,
              prefixIcon: const Icon(Icons.search),
              hintText: "Pesquisar",
              obscureText: false,
            ),
            const DividerWidget(
              textBetween: "LOTES",
              height: 40,
              thikness: 2.5,
              paddingLeft: 10,
              paddingRight: 10,
              color: Colors.blue,
              textColor: Colors.black,
              isBold: true,
            ),
            Column(
              children: [
                FutureBuilder(
                  future: listarLotes(context),
                  builder: (context, AsyncSnapshot<List<BatchModel>> snapshot) {
                    return AsyncSnapshotHandler(
                      asyncSnapshot: snapshot,
                      widgetOnError: _notFoundWidget(context),
                      widgetOnWaiting: const CircularProgressIndicator(),
                      widgetOnEmptyResponse: _notFoundWidget(context),
                      widgetOnSuccess: _listaLotes(context, snapshot.data),
                    ).handler();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _notFoundWidget(BuildContext context) {
    return BatchController().notFoundWidgetRedirect(
        context, ErrorMessage.usuarioSemLote, AppPaths.cadastroLotePath);
  }

  Widget _listaLotes(BuildContext context, List<BatchModel>? lotes) {
    List<BatchModel> batches = lotes ?? [];

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: batches.length,
          itemBuilder: (context, index) {
            BatchModel lote = batches[index];
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
                              TankScreen(
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
                            _resolverQtdeTanques(lote),
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
                              BatchForm(
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

  String _resolverQtdeTanques(BatchModel lote) {
    if (lote.tanques != null) {
      String qtde = lote.tanques!.length.toString();
      return qtde + (lote.tanques!.length > 1 ? " Tanques" : " Tanque");
    }
    return "0 tanques";
  }
}
