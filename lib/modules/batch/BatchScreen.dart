import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/modules/financial/FinancialForm.dart';
import 'package:fishcount_app/modules/financial/FinancialScreen.dart';
import 'package:fishcount_app/modules/financial/payment/PaymentService.dart';
import 'package:fishcount_app/modules/person/PessoaService.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/FilterOptionWidget.dart';
import 'package:fishcount_app/widgets/SnackBarBuilder.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:fishcount_app/widgets/custom/BottomSheetBuilder.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/exceptions/ErrorMessage.dart';
import '../../utils/AnimationUtils.dart';
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
  String _text = '';

  String _orderBy = 'none';

  final Map<String, bool> _filters = {
    'dataInclusao': false,
    'descricao': false,
  };
  final List<String> _filterFields = [
    'dataInclusao',
    'descricao',
  ];

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

      NavigatorUtils.push(
        context,
        FinancialScreen(
          pagamentos: pagamentos,
        ),
      );
      return;
    }
    NavigatorUtils.push(context, FinancialForm(pessoaModel: people));
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet(
        context: context,
        newFunction: () => _batchController.openBatchRegisterModal(
            (text) => setState(() => _text),
            context,
            TextEditingController(),
            _animationController,
            null),
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
      ).build(),
      body: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MediaQuery.of(context).orientation != Orientation.portrait
                      ? Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: FilterOptionWidget(
                                onTap: () =>
                                    _batchController.openBatchRegisterModal(
                                        (text) => setState(() => _text),
                                        context,
                                        TextEditingController(),
                                        _animationController,
                                        null),
                                text: 'Novo Lote',
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
                          text: 'Data Inclusão',
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
              future: fecthBatches(context),
              builder: (context, AsyncSnapshot<List<BatchModel>> snapshot) {
                return AsyncSnapshotHandler(
                  asyncSnapshot: snapshot,
                  widgetOnError: _notFoundWidget(context),
                  widgetOnWaiting: Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: AnimationUtils.progressiveDots(size: 50.0),
                  ),
                  widgetOnEmptyResponse: _notFoundWidget(context),
                  widgetOnSuccess: _batchList(context, snapshot.data),
                ).handler();
              },
            ),
          ],
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
            child: Text(
              ErrorMessage.usuarioSemLote,
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
              onPressed: () => _batchController
                  .openBatchRegisterModal(
                      (text) => setState(() => _text),
                      context,
                      TextEditingController(),
                      _animationController,
                      null)
                  .build(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _batchList(BuildContext context, List<BatchModel>? batchesModel) {
    final List<BatchModel> batches = batchesModel ?? [];
    final TextEditingController _editBatchNameController =
        TextEditingController();

    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[100];

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: batches.length,
          itemBuilder: (context, index) {
            final BatchModel batch = batches[index];
            final String inclusionDate = batch.inclusionDate.toString();
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
                          onTap: () => SnackBarBuilder.info(
                                  'Arraste para o lado para excluir!')
                              .buildInfo(context),
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
                                    batch.description.toUpperCase(),
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
                                  child: Text(
                                    'Data de inclusão: $inclusionDate',
                                    style: const TextStyle(
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
                                _editBatchNameController.text =
                                    batch.description,
                                _batchController.openBatchRegisterModal(
                                  (text) => setState(() => _text),
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
            ),
          ],
        );
      },
    );
  }

  _deleteBatch(List<BatchModel> batches, int index) {
    _batchService.deleteBath(batches[index].id!);
    Navigator.pop(context);
  }

  String _resolverQtdeTanques(BatchModel lote) {
    if (lote.tanks != null) {
      String qtde = lote.tanks!.length.toString();
      if (lote.tanks!.isEmpty) {
        return 'Nenhum tanque cadastrado';
      }
      return qtde + (lote.tanks!.length > 1 ? " Tanques" : " Tanque");
    }
    return "0 tanques";
  }
}
