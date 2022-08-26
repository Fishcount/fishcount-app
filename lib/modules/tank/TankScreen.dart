import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/tank/TankController.dart';
import 'package:fishcount_app/repository/TanqueRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/FilterOptionWidget.dart';
import 'TankForm.dart';
import 'TankService.dart';

class TankScreen extends StatefulWidget {
  final BatchModel batch;

  const TankScreen({
    Key? key,
    required this.batch,
  }) : super(key: key);

  @override
  State<TankScreen> createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen>
    with TickerProviderStateMixin{ 
  final TankService _tankService = TankService();
  final TankController _tankController = TankController();
  final ConnectionUtils _connectionUtils = ConnectionUtils();
  final TanqueRepository _tanqueRepository = TanqueRepository();
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

  Future<List<TankModel>> fetchTanks() async {
    bool isConnected = await _connectionUtils.isConnected();
    if (isConnected) {
      if (_orderBy != 'none') {
        return _tankService.fetchTanks(batch: widget.batch, orderBy: _orderBy);
      }
      return _tankService.fetchTanks(batch: widget.batch, orderBy: null);
    }
    return _tanqueRepository.listarTanques(context, widget.batch.id!);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _newTankController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
        context,
        () => _tankController.openBatchRegisterModal(context, _newTankController, _animationController, null),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              DividerWidget(
                textBetween: "TANQUES",
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
                future: fetchTanks(),
                builder: (context, AsyncSnapshot<List<TankModel>> snapshot) {
                  return AsyncSnapshotHandler(
                    asyncSnapshot: snapshot,
                    widgetOnError: const Text(""),
                    widgetOnWaiting: const CircularProgressIndicator(),
                    widgetOnEmptyResponse: _notFoundWidget(context),
                    widgetOnSuccess:
                        _tankList(context, snapshot.data, widget.batch),
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
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: const Text(
              ErrorMessage.usuarioSemTanque,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButtonWidget(
              buttonText: "Novo",
              textSize: 18,
              radioBorder: 20,
              horizontalPadding: 30,
              verticalPadding: 10,
              textColor: Colors.white,
              buttonColor: Colors.blue,
              onPressed: () {
                NavigatorUtils.push(
                  context,
                  TankForm(
                    batch: widget.batch,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text("Deseja realmente excluir esse tanque? "),
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
                      // batches.removeAt(index);
                    }),
                  },
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: "Confirmar",
                  buttonColor: Colors.green,
                  onPressed: () => {},
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

  Widget _tankList(
      BuildContext context, List<TankModel>? tanksModel, BatchModel batch) {
    final List<TankModel> tanks = tanksModel ?? [];
    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[200];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanks.length,
          itemBuilder: (context, index) {
            TankModel tankModel = tanks[index];
            return Dismissible(
              key: Key(tankModel.id!.toString()),
              onDismissed: (direction) => _showAlertDialog(context),
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
                          onTap: () => {},
                          // onTap: () => _showInfoSnackBar(context),
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
                                    tankModel.description,
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
                                    tankModel.fishAmount.toString() + ' Peixes',
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
                            // NavigatorUtils.pushReplacement(
                            //   context,
                            //   TankScreen(
                            //     lote: tankModel,
                            //   ),
                            // );
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
                                // _editBatchNameController.text =
                                //     tankModel.descricao,
                                // _batchController.openBatchRegisterModal(
                                //   context,
                                //   _editBatchNameController,
                                //   _animationController,
                                //   tankModel,
                                // )
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
}
