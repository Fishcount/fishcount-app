import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/AlertDialogBuilder.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomSnackBar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

import '../../constants/AppPaths.dart';
import '../../constants/exceptions/ErrorMessage.dart';
import '../../utils/NavigatorUtils.dart';
import '../../widgets/buttons/ElevatedButtonWidget.dart';
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
  BatchService batchService = BatchService();

  final TextEditingController _pesquisaController = TextEditingController();

  List<BatchModel> lotes = [];

  Future<List<BatchModel>>? listarLotes(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return batchService.fetchBatches();
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
                ),
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

    return ListView.builder(
      shrinkWrap: true,
      itemCount: batches.length,
      itemBuilder: (context, index) {
        BatchModel batch = batches[index];
        return Dismissible(
          key: Key(batch.id!.toString()),
          onDismissed: (direction) =>
              _showAlertDialog(context, direction, batches, index),
          background: Container(
            width: 200,
            color: Colors.red[400],
            margin: const EdgeInsets.only(top: 15, right: 10),
            child: Container(
              alignment: const Alignment(-0.9, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                right: BorderSide(
                  color: Colors.blue,
                ),
                left: BorderSide(
                  color: Colors.blue,
                ),
                top: BorderSide(
                  color: Colors.blue,
                ),
                bottom: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    child: const Icon(
                      Icons.drag_indicator_rounded,
                      size: 25,
                      color: Colors.red,
                    ),
                    onDoubleTap: () => _showInfoSnackBar(context),
                  ),
                ),
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
                              lote: batch,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            batch.descricao.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _resolverQtdeTanques(batch),
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'Data de inclusão: 10/10/2021',
                          style: TextStyle(
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
                        right: 20,
                        top: 12,
                        bottom: 12,
                      ),
                      width: 30,
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
                              lote: batch,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showAlertDialog(BuildContext context,
      DismissDirection direction, List<BatchModel> batches, int index) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Deseja realmente excluir esse lote? "),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: "Cancelar",
                  buttonColor: Colors.blue,
                  onPressed: () => {
                    Navigator.pop(context),
                    setState(() {
                      batches.removeAt(index);
                    }),
                  },
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: "Confirmar",
                  buttonColor: Colors.green,
                  onPressed: () => _deleteBatch(batches, index),
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  _deleteBatch(List<BatchModel> batches, int index) {
    batchService.deleteBath(batches[index].id!);
    Navigator.pop(context);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showInfoSnackBar(
      BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30,
            ),
            Text("Arraste para o lado para excluir !"),
          ],
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "",
          onPressed: () {},
        ),
      ),
    );
  }
}

String _resolverQtdeTanques(BatchModel lote) {
  if (lote.tanques != null) {
    String qtde = lote.tanques!.length.toString();
    if (lote.tanques!.isEmpty) {
      return 'Nenhum lote cadastrado';
    }
    return qtde + (lote.tanques!.length > 1 ? " Tanques" : " Tanque");
  }
  return "0 tanques";
}
