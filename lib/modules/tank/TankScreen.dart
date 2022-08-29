import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/model/enums/EnumUnidadeAumento.dart';
import 'package:fishcount_app/modules/species/SpecieService.dart';
import 'package:fishcount_app/modules/tank/TankController.dart';
import 'package:fishcount_app/repository/TanqueRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/buttons/TextButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../model/SpeciesModel.dart';
import '../../utils/AnimationUtils.dart';
import '../../widgets/FilterOptionWidget.dart';
import '../../widgets/SnackBarBuilder.dart';
import '../../widgets/TextFieldWidget.dart';
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

class _TankScreenState extends State<TankScreen> with TickerProviderStateMixin {
  final TankService _tankService = TankService();
  final SpeciesService _speciesService = SpeciesService();
  final TankController _tankController = TankController();
  final ConnectionUtils _connectionUtils = ConnectionUtils();
  final TanqueRepository _tanqueRepository = TanqueRepository();
  late AnimationController _animationController;

  String _orderBy = 'none';

  final Map<String, bool> _filters = {
    'dataUltimaAnalise': false,
    'descricao': false,
  };
  final List<String> _filterFields = [
    'dataUltimaAnalise',
    'descricao',
  ];

  @override
  initState() {
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(milliseconds: 300);
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
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
        context,
        () => openTankRegisterModal(
          context: context,
          fishAmounController: TextEditingController(),
          tankNameController: TextEditingController(),
          tankSpecie: "",
          animationController: _animationController,
          tankModel: null,
        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MediaQuery.of(context).orientation != Orientation.portrait
                        ? Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: FilterOptionWidget(
                                  onTap: () => openTankRegisterModal(
                                    context: context,
                                    fishAmounController:
                                        TextEditingController(),
                                    tankNameController: TextEditingController(),
                                    tankSpecie: "",
                                    animationController: _animationController,
                                    tankModel: null,
                                  ),
                                  text: 'Novo Tanque',
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: FilterOptionWidget(
                            backgroundColor: _filters[_filterFields[0]] == true
                                ? Colors.grey[300]
                                : Colors.white,
                            onTap: () => _setOrderBy(_filterFields[0]),
                            text: 'Data de análise',
                            icon: const Icon(Icons.date_range),
                          ),
                        ),
                        FilterOptionWidget(
                          backgroundColor: _filters[_filterFields[1]] == true
                              ? Colors.grey[300]
                              : Colors.white,
                          onTap: () => _setOrderBy(_filterFields[1]),
                          text: 'Ordem alfabética',
                          icon: const Icon(LineIcons.sortAlphabeticalDown),
                        ),
                      ],
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
                    widgetOnWaiting:  Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: AnimationUtils.progressiveDots(size: 50.0),
                    ),
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

  _setOrderBy(String selectedField) {
    if (_orderBy != selectedField) {
      setState(() => _orderBy = selectedField);
      _filters.update(_orderBy, (state) => true);

      _alternateFilterState();
    }
  }

  _alternateFilterState() {
    for (String field in _filterFields) {
      if (_orderBy != field) {
        _filters.update(field, (state) => false);
      }
    }
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

  Future<String?> _showAlertDialog(
      BuildContext context, int batchId, List<TankModel> tanks, int index) {
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
                      tanks.removeAt(index);
                    }),
                  },
                  textSize: 15,
                  textColor: Colors.white,
                  radioBorder: 10,
                ),
                ElevatedButtonWidget(
                  buttonText: "Confirmar",
                  buttonColor: Colors.green,
                  onPressed: () => _deleteTank(batchId, tanks, index),
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
    final TextEditingController _editTankNameController =
        TextEditingController();

    final TextEditingController _editAmountFishController =
        TextEditingController();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanks.length,
          itemBuilder: (context, index) {
            TankModel tankModel = tanks[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
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
              child: Dismissible(
                key: Key(tankModel.id!.toString()),
                onDismissed: (direction) =>
                    _showAlertDialog(context, batch.id!, tanks, index),
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red[400],
                  ),
                  margin: const EdgeInsets.only(right: 10),
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
                child: ExpansionTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const Divider(
                        height: 1,
                        thickness: 2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.only(right: 15),
                                child: Image.asset(ImagePaths.imageLogo),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Espécie: " +
                                          tankModel.species.description,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Peso Médio: " +
                                          tankModel.species.averageWeight
                                              .toString() +
                                          '0 ' +
                                          tankModel.species.unidadePesoMedio
                                              .toLowerCase() +
                                          's',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Quantidade de ração: " +
                                          tankModel.species.qtdeMediaRacao
                                              .toString() +
                                          ' ' +
                                          tankModel.species.unidadePesoRacao
                                              .toLowerCase() +
                                          's',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Tamanho médio: " +
                                          tankModel.species.tamanhoMedio
                                              .toString() +
                                          '0 ' +
                                          UnidadeAumentoHandler.getLowerCase(
                                              tankModel.species.unidadeTamanho),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextButton(
                                    child: Row(
                                      children: const [
                                        Text(
                                          "Análises disponíveis",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        Icon(
                                          Icons
                                              .keyboard_double_arrow_right_rounded,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 0, right: 10),
                              child: const Icon(
                                Icons.drag_indicator,
                                size: 30,
                              ),
                            ),
                            onTap: () => SnackBarBuilder.info(
                                    'Arraste para o lado para excluir!')
                                .buildInfo(context),
                          ),
                          GestureDetector(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.9,
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
                                      tankModel.fishAmount.toString() +
                                          ' Peixes',
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
                              // TODO abrir a tela de análises
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
                          onTap: () {
                            _editTankNameController.text =
                                tankModel.description;
                            _editAmountFishController.text =
                                tankModel.fishAmount.toString();
                            openTankRegisterModal(
                              context: context,
                              tankNameController: _editTankNameController,
                              fishAmounController: _editAmountFishController,
                              tankSpecie: tankModel.species.description,
                              animationController: _animationController,
                              tankModel: tankModel,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  openTankRegisterModal({
    context = BuildContext,
    tankNameController = TextEditingController,
    fishAmounController = TextEditingController,
    tankSpecie = String,
    animationController = AnimationController,
    tankModel = TankModel,
  }) async {
    final bool _isUpdate = tankModel != null;
    final List<SpeciesModel> species =
        await _tankController.resolverListaEspecie(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      transitionAnimationController: _animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 100
                          : 30,
                      bottom: 20),
                  child: Text(
                    _isUpdate ? "Atualizar Tanque" : "Cadastrar novo Tanque",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFieldWidget(
                    controller: tankNameController,
                    hintText: 'Nome do lote',
                    focusedBorderColor: Colors.blueGrey,
                    iconColor: Colors.blueGrey,
                    obscureText: false,
                    labelText: 'Nome do lote',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFieldWidget(
                    controller: fishAmounController,
                    hintText: 'Quantidade de peixes',
                    focusedBorderColor: Colors.blueGrey,
                    iconColor: Colors.blueGrey,
                    obscureText: false,
                    labelText: 'Quantidade inicial de peixes',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(232, 232, 232, 232),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: DropdownButton<String>(
                      value: tankSpecie != ""
                          ? tankSpecie
                          : species.first.description,
                      isExpanded: true,
                      items: species
                          .map(
                            (specie) => DropdownMenuItem(
                              value: specie.description,
                              child: Text(specie.description),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          tankSpecie = newValue ?? "";
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButtonWidget(
                        buttonText: "Cancelar",
                        buttonColor: Colors.blue,
                        onPressed: () => Navigator.pop(context),
                        textSize: 15,
                        textColor: Colors.white,
                        radioBorder: 10,
                        horizontalPadding: 20,
                        verticalPadding: 10,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButtonWidget(
                        buttonText: "Confirmar",
                        buttonColor: Colors.green,
                        onPressed: () async => await _confirmTank(
                            tankSpecie,
                            species,
                            _isUpdate,
                            tankModel,
                            tankNameController,
                            fishAmounController,
                            context),
                        textSize: 15,
                        textColor: Colors.white,
                        radioBorder: 10,
                        horizontalPadding: 20,
                        verticalPadding: 10,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<dynamic> _confirmTank(
    tankSpecie,
    List<SpeciesModel> species,
    bool _isUpdate,
    tankModel,
    tankNameController,
    fishAmounController,
    BuildContext context,
  ) async {
    final String speciesDescription =
        tankSpecie != "" ? tankSpecie : species.first.description;
    TankModel tank = tankModel ?? TankModel.empty(null);

    tankModel = await _generateTank(
        tank, tankNameController, fishAmounController, speciesDescription);
    if (_isUpdate) {
      return _tankController.updateTank(context, tankModel, widget.batch);
    }
    return _tankController.saveTank(context, tankModel, widget.batch);
  }

  Future<TankModel> _generateTank(tankModel, tankNameController,
      fishAmounController, String speciesDescription) async {
    tankModel.description = tankNameController.text;
    tankModel.fishAmount = int.parse(fishAmounController.text);
    tankModel.species =
        await _speciesService.findByDescricao(speciesDescription);

    return tankModel;
  }

  _deleteTank(int batchId, List<TankModel> tanks, int index) {
    _tankService.deleteTank(batchId, tanks[index].id!);
    setState(() {});
    Navigator.pop(context);
  }
}
