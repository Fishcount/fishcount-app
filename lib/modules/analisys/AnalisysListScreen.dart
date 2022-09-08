import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/AnalysisModel.dart';
import 'package:fishcount_app/modules/analisys/AnalisysService.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/FilterOptionWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:fishcount_app/widgets/custom/BottomSheetBuilder.dart';

import 'package:line_icons/line_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/TankModel.dart';
import '../../utils/ConnectionUtils.dart';
import '../../widgets/buttons/ElevatedButtonWidget.dart';

class AnalisysListScreen extends StatefulWidget {
  final TankModel tankModel;

  const AnalisysListScreen({
    Key? key,
    required this.tankModel,
  }) : super(key: key);

  @override
  State<AnalisysListScreen> createState() => _AnalisysListScreenState();
}

class _AnalisysListScreenState extends State<AnalisysListScreen> {
  final ConnectionUtils _connectionUtils = ConnectionUtils();
  final AnalisysService _analisysService = AnalisysService();

  String _orderBy = 'none';

  final Map<String, bool> _filters = {
    'AGUARDANDO_ANALISE': false,
    'ANALISE_CONCLUIDA': false,
  };
  final List<String> _filterFields = [
    'AGUARDANDO_ANALISE',
    'ANALISE_CONCLUIDA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet(
        context: context,
        newFunction: () => {},
      ).build(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              DividerWidget(
                textBetween: "Análises",
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
                                  onTap: () => {},
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
                            text: 'Aguardando análise',
                            icon: const Icon(Icons.connected_tv),
                          ),
                        ),
                        FilterOptionWidget(
                          backgroundColor: _filters[_filterFields[1]] == true
                              ? Colors.grey[300]
                              : Colors.white,
                          onTap: () => _setOrderBy(_filterFields[1]),
                          text: 'Concluidas',
                          icon: const Icon(Icons.download_done),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchAnalisys(),
                builder:
                    (context, AsyncSnapshot<List<AnalysisModel>> snapshot) {
                  return AsyncSnapshotHandler(
                    asyncSnapshot: snapshot,
                    widgetOnError: const Text(""),
                    widgetOnWaiting: Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: AnimationUtils.progressiveDots(size: 50.0),
                    ),
                    widgetOnEmptyResponse: _notFoundWidget(context),
                    widgetOnSuccess: _analysisList(context, snapshot.data!),
                    // _tankList(context, snapshot.data, widget.batch),
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
              ErrorMessage.tanqueSemAnalise,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButtonWidget(
              buttonText: "Iniciar a primeira análise!",
              textSize: 18,
              radioBorder: 20,
              horizontalPadding: 30,
              verticalPadding: 10,
              textColor: Colors.white,
              buttonColor: Colors.blue,
              onPressed: () =>
                  _analisysService.initiateAnalisys(widget.tankModel.id!),
            ),
          ),
        ],
      ),
    );
  }

  _setOrderBy(String selectedField) {
    if (_orderBy != selectedField) {
      setState(() => _orderBy = selectedField);
      _filters.update(_orderBy, (state) => true);

      _alternateFilterState();
      return;
    }
    if (_orderBy == selectedField) {
      setState(() => _orderBy = 'none');
      _filters.update(_filterFields[0], (state) => false);
      _filters.update(_filterFields[1], (state) => false);
    }
  }

  _alternateFilterState() {
    for (String field in _filterFields) {
      if (_orderBy != field) {
        _filters.update(field, (state) => false);
      }
    }
  }

  Future<List<AnalysisModel>> fetchAnalisys() async {
    // TODO verificar se esta conectado com internet
    if (_orderBy != 'none') {
      return _analisysService.fetchAnalisys(widget.tankModel.id!, _orderBy);
    }
    return _analisysService.fetchAnalisys(widget.tankModel.id!, null);
  }

  _analysisList(BuildContext context, List<AnalysisModel> analysisModels) {
    const Color borderColor = Colors.black26;
    final Color? backGroundColor = Colors.grey[100];
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height / 1.5
            : MediaQuery.of(context).size.height / 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: analysisModels.length,
          itemBuilder: (context, index) {
            AnalysisModel analysis = analysisModels[index];
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
              child: Text(analysis.analysisStatus),
            );
          },
        ),
      ),
    );
  }
}
