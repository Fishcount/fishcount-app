import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';

import '../../constants/AppImages.dart';
import '../../widgets/DividerWidget.dart';
import '../../widgets/custom/BottomSheetBuilder.dart';

class AnalisysScreen extends StatefulWidget {
  final TankModel tankModel;

  const AnalisysScreen({
    Key? key,
    required this.tankModel,
  }) : super(key: key);

  @override
  State<AnalisysScreen> createState() => _AnalisysScreenState();
}

class _AnalisysScreenState extends State<AnalisysScreen> {
  @override
  Widget build(BuildContext context) {
    final TankModel _tankModel = widget.tankModel;
    const Color borderColor = Colors.black26;
    final Color backGroundColor = Colors.grey.shade300;
    final Color shadowCardColor = Colors.blue.shade800;
    const fontTitleSize = 16.0;
    const fontDescriptionSize = 17.0;
    const cardHeight = 100.0;

    double cardWidth = MediaQuery.of(context).size.width / 2.3;

    _getBoxDecoration(Color backColor, Color border, bool useShadow, Color shadowColor) =>
        BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: useShadow
              ? [
                  BoxShadow(
                    offset: Offset.fromDirection(2, 2),
                    spreadRadius: 0.5,
                    // blurRadius: 0.5,
                    // blurStyle: BlurStyle.normal,
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
      bottomSheet:
          CustomBottomSheet(newFunction: () {}, context: context).build(),
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
                padding: const EdgeInsets.all(10),
                decoration: _getBoxDecoration(Colors.yellow, Colors.yellow, true, Colors.black26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: const Text(
                        // _tankModel.description.toUpperCase(),
                        "Análise iniciada, aguardando resposta do sonar..",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 25,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration:
                    _getBoxDecoration(backGroundColor, borderColor, true, shadowCardColor),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        _tankModel.description.toUpperCase(),
                        style: const TextStyle(
                            fontSize: fontTitleSize,
                            fontWeight: FontWeight.bold),
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
                          decoration: _getBoxDecoration(
                              Colors.white, borderColor, false, shadowCardColor),
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
                                      child: const Text(
                                        'Tilápia',
                                        style: TextStyle(
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
                                      child: const Text(
                                        '800 gramas',
                                        style: TextStyle(
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
                                      child: const Text(
                                        // '2.000 peixes',
                                        'Aguardando sonar..',
                                        style: TextStyle(
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
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: cardHeight,
                      width: cardWidth,
                      decoration:
                          _getBoxDecoration(backGroundColor, borderColor, true, shadowCardColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Temperatura da Água",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontTitleSize),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  // "28º",
                                  "Aguardando sonar..",
                                  // style: TextStyle(fontSize: 20),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Icon(
                                  LineIcons.highTemperature,
                                  color: Colors.blueGrey,
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
                      decoration:
                          _getBoxDecoration(backGroundColor, borderColor, true, shadowCardColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Ração estimada",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontTitleSize),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: const Text(
                                    // "40 Kg",
                                    "Aguardando sonar..",
                                    // style: TextStyle(fontSize: 20),
                                    style: TextStyle(fontSize: 15),
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: cardHeight,
                      width: cardWidth,
                      decoration:
                          _getBoxDecoration(backGroundColor, borderColor, true, shadowCardColor),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 5),
                                  child: const Text(
                                    // "2 - 3 mm",
                                    'Aguardando sonar..',
                                    // style: TextStyle(
                                    //   fontSize: fontTitleSize,
                                    //   overflow: TextOverflow.fade,
                                    // ),
                                    style: TextStyle(
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
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: cardHeight,
                      width: cardWidth,
                      decoration:
                          _getBoxDecoration(backGroundColor, borderColor, true, shadowCardColor),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: const Text(
                                    // "5 vezes",
                                    "Aguardando sonar..",
                                    style: TextStyle(fontSize: 15),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
