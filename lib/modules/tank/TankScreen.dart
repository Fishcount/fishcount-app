import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusAnalise.dart';
import 'package:fishcount_app/model/enums/EnumUnidadeAumento.dart';
import 'package:fishcount_app/modules/analisys/AnalysisListScreen.dart';
import 'package:fishcount_app/modules/financial/FinancialForm.dart';
import 'package:fishcount_app/modules/financial/FinancialScreen.dart';
import 'package:fishcount_app/modules/financial/payment/PaymentService.dart';
import 'package:fishcount_app/modules/person/PessoaService.dart';
import 'package:fishcount_app/modules/tank/TankController.dart';
import 'package:fishcount_app/modules/tank/TankForm.dart';
import 'package:fishcount_app/repository/TanqueRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:fishcount_app/widgets/custom/BottomSheetBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/AnimationUtils.dart';
import '../../utils/NavigatorUtils.dart';
import '../../widgets/FilterOptionWidget.dart';
import '../../widgets/SnackBarBuilder.dart';
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

  bool _personHasCpf(PersonModel pessoa) =>
      pessoa.cpf != null && pessoa.cpf!.isNotEmpty;

  final PersonService _personService = PersonService();
  final PaymentService _paymentService = PaymentService();

  Future<void> _handlePermissions(StateSetter setState) async {
    setState(() => loading = true);

    final PersonModel people = await _personService.findById();
    if (_personHasCpf(people)) {
      final List<PaymentModel> pagamentos =
          await _paymentService.buscarPagamentos();

      NavigatorUtils.pushWithFadeAnimation(
        context,
        FinancialScreen(
          pagamentos: pagamentos,
        ),
      );
      setState(() => loading = false);
      return;
    }
    NavigatorUtils.pushWithFadeAnimation(
        context, FinancialForm(pessoaModel: people));
    setState(() => loading = false);
  }

  bool loading = false;
  bool loadingButtonNew = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet(
        context: context,
        centerElement: Center(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return loading
                  ? AnimationUtils.threeRotatungDots(
                      size: 30.0, color: Colors.white)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: const Icon(
                            Icons.monetization_on_outlined,
                            size: 35,
                            color: Colors.white,
                          ),
                          onTap: () async => await _handlePermissions(setState),
                        ),
                        const Text(
                          "Financeiro",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        newFunction: () async => await TankForm(
          context,
          null,
          widget.batch,
          "",
          _animationController,
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ).openRegisterModal(),
      ).build(),
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
                                  onTap: () async => await TankForm(
                                    context,
                                    null,
                                    widget.batch,
                                    "",
                                    _animationController,
                                    TextEditingController(),
                                    TextEditingController(),
                                    TextEditingController(),
                                  ).openRegisterModal(),
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
                    widgetOnError: const Text(
                        "Não foi possível buscar os tanques desse lote."),
                    widgetOnWaiting: Container(
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
          StatefulBuilder(
            builder: (context, setState) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 50),
                child: loadingButtonNew
                    ? AnimationUtils.progressiveDots(size: 50.0)
                    : ElevatedButtonWidget(
                        buttonText: "Novo",
                        textSize: 18,
                        radioBorder: 20,
                        horizontalPadding: 30,
                        verticalPadding: 10,
                        textColor: Colors.white,
                        buttonColor: Colors.blue,
                        onPressed: () async {
                          setState(() => loadingButtonNew = true);
                          await TankForm(
                            context,
                            null,
                            widget.batch,
                            "",
                            _animationController,
                            TextEditingController(),
                            TextEditingController(),
                            TextEditingController(),
                          ).openRegisterModal();
                          setState(() => loadingButtonNew = false);
                        },
                      ),
              );
            },
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
    final Color? backGroundColor = Colors.grey[100];
    final TextEditingController _editTankNameController =
        TextEditingController();

    final TextEditingController _editAmountFishController =
        TextEditingController();

    final TextEditingController _editInicialWeigthController =
        TextEditingController();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.6
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
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
                                child: Image.asset(ImagePaths.fish),
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
                                              .toString().replaceAll('.', ',') +
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
                                              .toString().replaceAll('.', ',') +
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
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: TextButton(
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Visualizar análises",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Icon(
                                        Icons
                                            .keyboard_double_arrow_right_rounded,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    NavigatorUtils
                                        .pushReplacementWithFadeAnimation(
                                      context,
                                      // AnalisysScreen(tankModel: tankModel),
                                      AnalysisListScreen(
                                          tankModel: tankModel,
                                          batchId: widget.batch.id!),
                                    );
                                  },
                                ),
                              ),
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
                            child: Container(
                              alignment: Alignment.centerLeft,
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
                                      tankModel.lastFishAmount == null ||
                                              tankModel.lastFishAmount == 0
                                          ? tankModel.fishAmount.toString()
                                          : tankModel.lastFishAmount
                                                  .toString() +
                                              ' Peixes',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          StatusAnaliseHandler.handlerText(
                                              tankModel.analisyStatus!),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: StatusAnaliseHandler
                                                .handlerColor(
                                                    tankModel.analisyStatus!),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () =>
                                NavigatorUtils.pushReplacementWithFadeAnimation(
                              context,
                              AnalysisListScreen(
                                  tankModel: tankModel, batchId: batch.id!),
                            ),
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
                            _editInicialWeigthController.text =
                                tankModel.initialWeight.toString();
                            _tankController.openTankRegisterModal(
                                context,
                                _editTankNameController,
                                _editAmountFishController,
                                _editInicialWeigthController,
                                tankModel.species.description,
                                _animationController,
                                tankModel,
                                widget.batch);
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

  _deleteTank(int batchId, List<TankModel> tanks, int index) {
    _tankService.deleteTank(batchId, tanks[index].id!);
    setState(() {});
    Navigator.pop(context);
  }
}
