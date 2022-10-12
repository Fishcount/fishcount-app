import 'package:fishcount_app/model/AnalysisModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/analisys/AnalysisController.dart';
import 'package:fishcount_app/modules/analisys/AnalysisService.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/AppImages.dart';
import '../../widgets/DividerWidget.dart';
import '../../widgets/custom/BottomSheetBuilder.dart';

class AnalysisScreen extends StatefulWidget {
  final TankModel tankModel;
  final AnalysisModel analysisModel;
  final int bacthId;

  const AnalysisScreen({
    Key? key,
    required this.tankModel,
    required this.analysisModel,
    required this.bacthId
  }) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final AnalysisService _analysisService = AnalysisService();
  final AnalysisController _analysisController = AnalysisController();
  final String waitingSonar = 'Aguardando sonar..';

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

  @override
  Widget build(BuildContext context) {
    final TankModel _tankModel = widget.tankModel;
    final AnalysisModel _analysisModel = widget.analysisModel;

    final String analysisStatus = _analysisModel.analysisStatus;
    final bool isConcluded = analysisStatus != 'AGUARDANDO_ANALISE';

    final String fishAmount = isConcluded
        ? _tankModel.fishAmount.toString() + ' peixes'
        : waitingSonar;

    final String dailyFoodAmount = isConcluded
        ? _analysisModel.dailyFoodAmount.toString() + '0 KG'
        : waitingSonar;

    final String mealFoodAmount = isConcluded
        ? _analysisModel.mealFoodAmout.toString() + '0 KG'
        : waitingSonar;

    final String foodType =
        isConcluded ? _analysisModel.foodType.toString() : waitingSonar;

    final String dailyFrequency = isConcluded
        ? _analysisModel.dailyFoodFrequency.toString() + ' vezes ao dia'
        : waitingSonar;

    final tankWeight = isConcluded
        ? _analysisModel.avergageTankWeight.toString() + '0 Kg'
        : waitingSonar;

    final tankTemperature = isConcluded
        ? _tankModel.hasTemperatureGauge
            ? _analysisModel.tankTemperature.toString() + ' ºC'
            : waitingSonar
        : waitingSonar;

    final int tankId = _tankModel.id!;
    final int analysisId = _analysisModel.id!;
    final int batchId= widget.bacthId;

    const Color borderColor = Colors.black26;
    final Color backGroundColor = Colors.grey.shade100;
    final Color shadowCardColor = Colors.blue.shade800;
    const fontTitleSize = 16.0;
    const fontDescriptionSize = 17.0;
    const cardHeight = 100.0;

    double cardWidth = MediaQuery.of(context).size.width / 2.3;

    _getBoxDecoration(
            Color backColor, Color border, bool useShadow, Color shadowColor) =>
        BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: useShadow
              ? [
                  BoxShadow(
                    offset: Offset.fromDirection(2, 2),
                    spreadRadius: 0.5,
                    color: shadowColor,
                  ),
                ]
              : [],
          border: Border(
            right: BorderSide(
              color: border,
            ),
            left: BorderSide(
              color: border,
            ),
            top: BorderSide(
              color: border,
            ),
            bottom: BorderSide(
              color: border,
            ),
          ),
        );

    return Scaffold(
      appBar: AppBarBuilder().build(),
      drawer: const DrawerWidget(),
      bottomSheet: CustomBottomSheet(
        newFunction: () {},
        context: context,
        rightElement: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Icon(
                LineIcons.syncIcon,
                size: 35,
                color: Colors.white,
              ),
              onTap: () => _analysisController.openAnalysisModal(
                context,
                _animationController,
                widget.tankModel,
                analysisId,
                batchId,
              ),
            ),
            const Text(
              "Simular",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ).build(tankModel: widget.tankModel),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              DividerWidget(
                textBetween: "Análise".toUpperCase(),
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                isBold: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: _getBoxDecoration(
                    backGroundColor, borderColor, true, shadowCardColor),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        _tankModel.description.toUpperCase(),
                        style: const TextStyle(
                          fontSize: fontTitleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(left: 10),
                          width: 150,
                          height: 190,
                          decoration: _getBoxDecoration(Colors.white,
                              borderColor, false, shadowCardColor),
                          child: Image.asset(ImagePaths.imageLogo),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 20, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Espécie: ',
                                      style: TextStyle(
                                        fontSize: fontTitleSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                      child: Divider(
                                        color: Colors.lightBlueAccent,
                                        height: 1,
                                        thickness: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      child: Text(
                                        _tankModel.species.description,
                                        style: const TextStyle(
                                          fontSize: fontDescriptionSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Peso Médio: ',
                                      style: TextStyle(
                                        fontSize: fontTitleSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                      child: Divider(
                                        color: Colors.lightBlueAccent,
                                        height: 1,
                                        thickness: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      child: Text(
                                        _tankModel.initialWeight.toString(),
                                        style: const TextStyle(
                                          fontSize: fontDescriptionSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Quantidade de peixes: ',
                                      style: TextStyle(
                                        fontSize: fontTitleSize,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 170,
                                      child: Divider(
                                        color: Colors.lightBlueAccent,
                                        height: 1,
                                        thickness: 1,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      child: Text(
                                        fishAmount,
                                        style: const TextStyle(
                                            fontSize: fontDescriptionSize),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: SizedBox(
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height / 2.5
                          : MediaQuery.of(context).size.height / 3,
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: cardHeight,
                              width: cardWidth,
                              decoration: _getBoxDecoration(backGroundColor,
                                  borderColor, true, shadowCardColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Ração por refeição",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontTitleSize),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            mealFoodAmount,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.blur_linear_outlined,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: cardHeight,
                              width: cardWidth,
                              decoration: _getBoxDecoration(backGroundColor,
                                  borderColor, true, shadowCardColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Ração diária",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontTitleSize),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            dailyFoodAmount,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.blur_linear_outlined,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: cardHeight,
                              width: cardWidth,
                              decoration: _getBoxDecoration(backGroundColor,
                                  borderColor, true, shadowCardColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Frequência diária",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontTitleSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                            dailyFrequency,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.alarm_on_outlined,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: cardHeight,
                              width: cardWidth,
                              decoration: _getBoxDecoration(backGroundColor,
                                  borderColor, true, shadowCardColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Tipo de ração",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontTitleSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, right: 5),
                                          child: Text(
                                            foodType,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.backpack_rounded,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      !_tankModel.hasTemperatureGauge
                          ? Container(
                              height: cardHeight,
                              width: cardWidth,
                              decoration: _getBoxDecoration(backGroundColor,
                                  borderColor, true, shadowCardColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "Peso total do tanque",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontTitleSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, right: 5),
                                          child: Text(
                                            tankWeight,
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          LineIcons.fish,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      _tankModel.hasTemperatureGauge
                          ? Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: cardHeight,
                                    width: cardWidth,
                                    decoration: _getBoxDecoration(
                                        backGroundColor,
                                        borderColor,
                                        true,
                                        shadowCardColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: const Text(
                                            "Peso total do tanque",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: fontTitleSize,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5, right: 5),
                                                child: Text(
                                                  tankWeight,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              const Icon(
                                                LineIcons.fish,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: cardHeight,
                                    width: cardWidth,
                                    decoration: _getBoxDecoration(
                                        backGroundColor,
                                        borderColor,
                                        true,
                                        shadowCardColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: const Text(
                                            "Temperatura da Água",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: fontTitleSize),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                tankTemperature,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              const Icon(
                                                LineIcons.highTemperature,
                                                color: Colors.blueGrey,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
