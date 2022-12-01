import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/analisys/AnalysisListScreen.dart';
import 'package:fishcount_app/modules/analisys/AnalysisService.dart';
import 'package:fishcount_app/modules/generic/AbstractController.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnalysisController extends AbstractController {
  final AnalysisService _analisysService = AnalysisService();

  openAnalysisModal(
      BuildContext context,
      AnimationController _animationController,
      TankModel tankModel,
      int? analysisId,
      int? batchId) async {
    TextEditingController _temperatureController = TextEditingController();
    TextEditingController _actualWeightController = TextEditingController();
    TextEditingController _fishAmountController = TextEditingController();
    bool _submitted = false;
    bool isGrams = false;
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


        bool loading = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 650,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 70, bottom: 35),
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
                            controller: _temperatureController,
                            hintText: 'Temperatura do tanque',
                            focusedBorderColor: Colors.blueGrey,
                            iconColor: Colors.blueGrey,
                            obscureText: false,
                            labelText: 'Temperatura do tanque',
                            keyBoardType: TextInputType.number,
                            errorText: resolveErrorText(
                              controller: _temperatureController,
                              submitted: _submitted,
                              errorMessage:
                                  'Temperatura do tanque não pode estar vazia.',
                            ),
                            onChanged: (text) => setState(() => resolveOnChaged(
                                _temperatureController, _submitted, text)),
                          ),
                        )
                      : Container(),
                  analysisId == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: TextFieldWidget(
                                controller: _actualWeightController,
                                hintText: 'Peso Atual',
                                focusedBorderColor: Colors.blueGrey,
                                iconColor: Colors.blueGrey,
                                obscureText: false,
                                labelText: 'Peso atual dos peixes',
                                keyBoardType: TextInputType.number,
                                errorText: resolveErrorText(
                                  controller: _actualWeightController,
                                  submitted: _submitted,
                                  errorMessage:
                                      'Peso dos peixes não pode estar vazio.',
                                ),
                                onChanged: (text) => setState(() =>
                                    resolveOnChaged(_actualWeightController,
                                        _submitted, text)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => isGrams = true),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 25, right: 15),
                                width: 50,
                                height: 40,
                                child: const Center(child: Text("Gr")),
                                decoration: BoxDecoration(
                                  color:
                                      !isGrams ? noSelectedColor : selectedColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: border,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => isGrams = false),
                              child: Container(
                                margin: const EdgeInsets.only(top: 25),
                                width: 50,
                                height: 40,
                                child: const Center(child: Text("Kg")),
                                decoration: BoxDecoration(
                                  color: isGrams
                                      ? noSelectedColor
                                      : selectedColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: border,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: TextFieldWidget(
                            controller: _fishAmountController,
                            hintText: 'Quantidade de peixes simulada',
                            focusedBorderColor: Colors.blueGrey,
                            iconColor: Colors.blueGrey,
                            obscureText: false,
                            labelText: 'Quantidade de peixes simulada',
                            keyBoardType: TextInputType.number,
                            errorText: resolveErrorText(
                              controller: _fishAmountController,
                              submitted: _submitted,
                              errorMessage:
                                  'Quantidade de peixes não pode estar vazia.',
                            ),
                            onChanged: (text) => setState(() => resolveOnChaged(
                                _fishAmountController, _submitted, text)),
                          ),
                        ),
                  loading
                      ? Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: AnimationUtils.progressiveDots(size: 50.0),
                        )
                      : Container(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButtonWidget(
                            buttonText: "Confirmar",
                            buttonColor: Colors.green,
                            textSize: 15,
                            textColor: Colors.white,
                            radioBorder: 10,
                            horizontalPadding: 20,
                            verticalPadding: 10,
                            onPressed: () {
                              setState(() => _submitted = true);
                              setState(() => loading = true);
                              if ((tankModel.hasTemperatureGauge &&
                                      _temperatureController.text.isEmpty) ||
                                  (analysisId != null &&
                                      _fishAmountController.text.isEmpty) ||
                                  (analysisId == null &&
                                      _actualWeightController.text.isEmpty)) {
                                setState(() => loading = false);
                                return;
                              }
                              if (analysisId == null) {
                                _initiateAnalysisAndUpdate(
                                  _temperatureController.text,
                                  _actualWeightController.text,
                                  tankModel,
                                  isGrams,
                                  batchId,
                                  context,
                                );
                              } else {
                                _simulateAnalysis(
                                    tankModel,
                                    _temperatureController.text,
                                    _fishAmountController.text,
                                    analysisId,
                                    batchId,
                                    context);
                              }
                            },
                          ),
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _simulateAnalysis(TankModel tankModel, String temperature, String fishAmount,
      int analysisId, int? batchId, BuildContext context) async {
    dynamic response = await _analisysService.simulateAnalysis(
        tankModel.id!, analysisId, temperature, fishAmount);
    afterRequestAlertDialog(
      response: response,
      redirect: AnalysisListScreen(tankModel: tankModel, batchId: batchId!),
      context: context
    );
  }

  _initiateAnalysisAndUpdate(
      String temperature,
      String actualWeight,
      TankModel tankModel,
      bool isGrams,
      int? batchId,
      BuildContext context) async {
    dynamic response = await _analisysService.initiateAnalisys(
        tankModel.id!, actualWeight, isGrams ? 'GRAMA' : 'KILO', temperature);

    afterRequestAlertDialog(
      response: response,
      context: context,
      redirect: AnalysisListScreen(tankModel: tankModel, batchId: batchId!)
    );
  }
}
