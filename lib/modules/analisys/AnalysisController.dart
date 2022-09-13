import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/analisys/AnalisysListScreen.dart';
import 'package:fishcount_app/modules/analisys/AnalisysService.dart';
import 'package:fishcount_app/modules/generic/AbstractController.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalysisController extends AbstractController {
  final AnalisysService _analisysService = AnalisysService();

  openAnalysisModal(
    BuildContext context,
    AnimationController _animationController,
    TankModel tankModel,
    TextEditingController temperatureController,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: false,
      transitionAnimationController: _animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        bool isGrams = false;

        final Color selectedColor = Colors.grey.shade500;
        final Color noSelectedColor = Colors.grey.shade300;
        const Color borderColor = Colors.black;
        const Border border = Border(
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
        );
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: const Text(
                    "Informações iniciais",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                tankModel.hasTemperatureGauge
                    ? Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFieldWidget(
                          controller: temperatureController,
                          hintText: 'Temperatura do tanque',
                          focusedBorderColor: Colors.blueGrey,
                          iconColor: Colors.blueGrey,
                          obscureText: false,
                          labelText: 'Temperatura',
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextFieldWidget(
                        controller: temperatureController,
                        hintText: 'Peso Atual',
                        focusedBorderColor: Colors.blueGrey,
                        iconColor: Colors.blueGrey,
                        obscureText: false,
                        labelText: 'Peso atual dos peixes',
                        keyBoardType: TextInputType.number,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isGrams = false),
                      child: Container(
                        margin: const EdgeInsets.only(top: 25, right: 15),
                        width: 50,
                        height: 40,
                        child: const Center(child: Text("KG")),
                        decoration: BoxDecoration(
                          color: isGrams ? noSelectedColor : selectedColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: border,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isGrams = true),
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        width: 50,
                        height: 40,
                        child: const Center(child: Text("GR")),
                        decoration: BoxDecoration(
                          color: !isGrams ? noSelectedColor : selectedColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: border,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: "Confirmar",
                    buttonColor: Colors.green,
                    textSize: 15,
                    textColor: Colors.white,
                    radioBorder: 10,
                    horizontalPadding: 20,
                    verticalPadding: 10,
                    onPressed: () => _initiateAnalysisAndUpdate(
                        temperatureController.text, tankModel, context),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _initiateAnalysisAndUpdate(
      String temperature, TankModel tankModel, BuildContext context) async {
    await _analisysService.initiateAnalisys(tankModel.id!, temperature);
    NavigatorUtils.pushReplacement(
        context, AnalisysListScreen(tankModel: tankModel));
  }
}
