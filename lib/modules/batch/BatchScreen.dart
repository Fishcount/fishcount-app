import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/FilterOptionWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/AppPaths.dart';
import '../../constants/exceptions/ErrorMessage.dart';
import '../../utils/NavigatorUtils.dart';
import '../../widgets/buttons/ElevatedButtonWidget.dart';
import '../tank/TankScreen.dart';
import 'BatchController.dart';
import 'BatchService.dart';

class BatchScreen extends StatefulWidget {
  final AuthUserModel? authUserModel;

  const BatchScreen({Key? key, this.authUserModel}) : super(key: key);

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen>
    with TickerProviderStateMixin {
  final BatchService _batchService = BatchService();
  final BatchController _batchController = BatchController();
  final List<BatchModel> lotes = [];
  late AnimationController _animationController;

  String _orderBy = 'none';

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

  Future<List<BatchModel>>? fecthBatches(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      if (_orderBy != 'none') {
        print(_orderBy);
        return _batchService.fetchBatches(_orderBy);
      }
      return _batchService.fetchBatches(null);
    }
    return LoteRepository().listarLotesUsuario(context);
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _newBatchController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
          context,
          () => _batchController.openBatchRegisterModal(
              context, _newBatchController, _animationController, null)),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              DividerWidget(
                textBetween: "LOTES",
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                isBold: true,
              ),
              Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: FilterOptionWidget(
                        onTap: () => setState(() => _orderBy = 'dataInclusao'),
                        text: 'Data Inclusão',
                        icon: const Icon(Icons.date_range),
                      ),
                    ),
                    FilterOptionWidget(
                      onTap: () => setState(() => _orderBy = 'descricao'),
                      text: 'Ordem alfabética',
                      icon: const Icon(LineIcons.sortAlphabeticalDown),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fecthBatches(context),
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
        ),
      ),
    );
  }

  Widget _notFoundWidget(BuildContext context) {
    return BatchController().notFoundWidgetRedirect(
        context, ErrorMessage.usuarioSemLote, AppPaths.cadastroLotePath);
  }

  Widget _listaLotes(BuildContext context, List<BatchModel>? batchesModel) {
    final List<BatchModel> batches = batchesModel ?? [];
    final TextEditingController _editBatchNameController =
        TextEditingController();

    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[200];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: batches.length,
          itemBuilder: (context, index) {
            BatchModel batch = batches[index];
            return Dismissible(
              key: Key(batch.id!.toString()),
              onDismissed: (direction) =>
                  _showAlertDialog(context, direction, batches, index),
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red[400],
                ),
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
                    ],
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                height: 90,
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: const Border(
                    right: BorderSide(
                      color: borderColor,
                    ),
                    left: BorderSide(
                      color: borderColor,
                    ),
                    top: BorderSide(
                      color: borderColor,
                    ),
                    bottom: BorderSide(
                      color: borderColor,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Icon(
                              Icons.drag_indicator,
                              size: 30,
                              // color: Colors.red,
                            ),
                          ),
                          onTap: () => _showInfoSnackBar(context),
                        ),
                        GestureDetector(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
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
                          onTap: () {
                            NavigatorUtils.pushReplacement(
                              context,
                              TankScreen(
                                batch: batch,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
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
                            size: 30,
                          ),
                          onTap: () => {
                                _editBatchNameController.text = batch.descricao,
                                _batchController.openBatchRegisterModal(
                                  context,
                                  _editBatchNameController,
                                  _animationController,
                                  batch,
                                )
                              }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<String?> _showAlertDialog(BuildContext context,
      DismissDirection direction, List<BatchModel> batches, int index) {
    return showDialog<String>(
      context: context,
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
    _batchService.deleteBath(batches[index].id!);
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
