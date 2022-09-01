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
    final Color? backGroundColor = Colors.grey[100];
    _getBoxDecoration(Color color) => BoxDecoration(
          color: color,
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
        );

    const fontTitleSize = 16.0;
    const fontDescriptionSize = 17.0;
    const cardHeight = 100.0;
    double cardWidth = MediaQuery.of(context).size.width / 2.3;

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
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        _tankModel.description.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 2,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: _getBoxDecoration(backGroundColor!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 10),
                      width: 150,
                      height: 190,
                      decoration: _getBoxDecoration(Colors.white),
                      child: Image.asset(ImagePaths.imageLogo),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
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
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
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
                                Text(
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
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
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
                                Text(
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
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    '2.000 peixes',
                                    style: TextStyle(
                                      fontSize: fontDescriptionSize,
                                    ),
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
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: cardHeight,
                      width: cardWidth,
                      decoration: _getBoxDecoration(backGroundColor),
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
                                  "28º",
                                  style: TextStyle(fontSize: 20),
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
                      decoration: _getBoxDecoration(backGroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: const Text(
                              "Racao estimada",
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: const Text(
                                    "40 Kg",
                                    style: TextStyle(fontSize: 20),
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
                      padding: const EdgeInsets.all(10),
                      height: cardHeight,
                      width: cardWidth,
                      decoration: _getBoxDecoration(backGroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
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
                                  padding: const EdgeInsets.only(top: 5, right: 5),
                                  child: const Text(
                                    "2 - 3 mm",
                                    style: TextStyle(
                                      fontSize: fontTitleSize,
                                      overflow: TextOverflow.fade,
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
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 10),
                      height: cardHeight,
                      width: cardWidth,
                      decoration: _getBoxDecoration(backGroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: const Text(
                                    "5 vezes",
                                    style: TextStyle(fontSize: 17),
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
