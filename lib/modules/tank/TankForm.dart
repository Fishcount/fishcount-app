import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/SpeciesModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/modules/species/SpecieService.dart';
import 'package:fishcount_app/modules/tank/TankScreen.dart';
import 'package:fishcount_app/modules/tank/TankService.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TankForm {
  BuildContext context;

  TankModel? tankModel;

  BatchModel batchModel;

  String tankSpecie;

  AnimationController animationController;

  TextEditingController tankNameController;

  TextEditingController fishAmounController;

  TextEditingController initialWeightController;

  final TankService _tankService = TankService();

  final SpeciesService _speciesService = SpeciesService();

  TankForm(
    this.context,
    this.tankModel,
    this.batchModel,
    this.tankSpecie,
    this.animationController,
    this.tankNameController,
    this.fishAmounController,
    this.initialWeightController,
  );

  Future<void> openRegisterModal() async {
    final bool _isUpdate = tankModel != null;
    final List<SpeciesModel> _species = await _speciesService.listarEspecies(context);

    bool? _hasTemperature = false;
    bool _submitted = false;
    bool _loading = false;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      transitionAnimationController: animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        bool isGrams = false;

        final Color selectedColor = Colors.grey.shade600;
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
                      color: Colors.black54,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFieldWidget(
                    controller: tankNameController,
                    hintText: 'Nome do tanque',
                    focusedBorderColor: Colors.blueGrey,
                    iconColor: Colors.blueGrey,
                    obscureText: false,
                    keyBoardType: TextInputType.streetAddress,
                    labelText: 'Nome do tanque',
                    errorText: resolveErrorText(
                      controller: tankNameController,
                      submitted: _submitted,
                      errorMessage: 'O nome do tanque não pode estar vazio.',
                    ),
                    onChanged: (text) => setState(() =>
                        resolveOnChaged(tankNameController, _submitted, text)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextFormField(
                    onChanged: (text) => setState(() =>
                        resolveOnChaged(tankNameController, _submitted, text)),
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
                    ],
                    controller: fishAmounController,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                      errorText: resolveErrorText(
                        controller: fishAmounController,
                        submitted: _submitted,
                        errorMessage:
                            'A quantidade de peixes não deve estar vazia.',
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.red),
                      ),
                      labelText: 'Quantidade inicial de peixes',
                      filled: true,
                      hintText: 'Quantidade de peixes',
                      prefixIconColor: Colors.blueGrey,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          style: BorderStyle.none,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.blueGrey,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  // TextFieldWidget(
                  //   controller: fishAmounController,
                  //   hintText: 'Quantidade de peixes',
                  //   focusedBorderColor: Colors.blueGrey,
                  //   iconColor: Colors.blueGrey,
                  //   obscureText: false,
                  //   labelText: 'Quantidade inicial de peixes',
                  //   keyBoardType: TextInputType.number,
                  //   errorText:
                  //       resolverFishAmount(fishAmounController, _submitted),
                  //   onChanged: (text) => setState(
                  //     () => resolverFishAmountOnChange(
                  //         fishAmounController, _submitted, text),
                  //   ),
                  // ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextFieldWidget(
                        controller: initialWeightController,
                        hintText: 'Peso Inicial',
                        focusedBorderColor: Colors.blueGrey,
                        iconColor: Colors.blueGrey,
                        obscureText: false,
                        labelText: 'Peso unitário inicial',
                        keyBoardType: TextInputType.phone,
                        errorText: resolveErrorText(
                            controller: initialWeightController,
                            submitted: _submitted,
                            errorMessage:
                                ' O peso inicial dos peixes não pode estar vazio.'),
                        onChanged: (text) => setState(
                          () => resolveOnChaged(
                              fishAmounController, _submitted, text),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isGrams = true),
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        width: 50,
                        height: 40,
                        child: const Center(child: Text("Gr")),
                        decoration: BoxDecoration(
                          color: !isGrams ? noSelectedColor : selectedColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: border,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isGrams = false),
                      child: Container(
                        margin: const EdgeInsets.only(top: 25, left: 15),
                        width: 50,
                        height: 40,
                        child: const Center(child: Text("Kg")),
                        decoration: BoxDecoration(
                          color: isGrams ? noSelectedColor : selectedColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: border,
                        ),
                      ),
                    ),
                  ],
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
                        : _species.first.description,
                    isExpanded: true,
                    items: _species
                        .map(
                          (specie) => DropdownMenuItem(
                            value: specie.description,
                            child: Text(specie.description),
                          ),
                        )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          tankSpecie = newValue ?? "";
                        },
                      );
                    },
                  ),
                ),
                Container(
                  child: CheckboxListTile(
                    title: const Text("Possui medidor temperatura"),
                    value: _hasTemperature,
                    onChanged: (newValue) {
                      setState(() => _hasTemperature = newValue);
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                _loading
                    ? Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: AnimationUtils.progressiveDots(size: 50.0),
                      )
                    : Row(
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
                              textSize: 15,
                              textColor: Colors.white,
                              radioBorder: 10,
                              horizontalPadding: 20,
                              verticalPadding: 10,
                              onPressed: () async {
                                setState(() => _submitted = true);
                                if (isInvalid(initialWeightController,
                                    fishAmounController, tankNameController)) {
                                  return;
                                }
                                setState(() => _loading = true);
                                await _confirmTank(
                                  tankSpecie,
                                  _species,
                                  _isUpdate,
                                  tankModel,
                                  batchModel,
                                  tankNameController,
                                  fishAmounController,
                                  initialWeightController,
                                  isGrams ? 'GRAMA' : 'KILO',
                                  context,
                                  _hasTemperature!,
                                );
                                setState(() => _loading = false);
                              },
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
      String tankSpecie,
      List<SpeciesModel> species,
      bool _isUpdate,
      TankModel? tankModel,
      BatchModel batchModel,
      TextEditingController tankNameController,
      TextEditingController fishAmounController,
      TextEditingController initialWeightController,
      String weitghUnity,
      BuildContext context,
      bool hasTemperature) async {
    final String speciesDescription =
        tankSpecie != "" ? tankSpecie : species.first.description;
    final TankModel tank = tankModel ?? TankModel.empty(null);

    tankModel = await _generateTank(
        tank,
        tankNameController,
        fishAmounController,
        speciesDescription,
        double.parse(initialWeightController.text),
        weitghUnity,
        hasTemperature);
    if (_isUpdate) {
      return updateTank(context, tankModel, batchModel);
    }
    return saveTank(context, tankModel, batchModel);
  }

  Future<dynamic> saveTank(
      BuildContext context, TankModel tank, BatchModel batch) async {
    dynamic response = await _tankService.saveTank(tank, batch.id!);

    return afterRequestAlertDialog(
      context: context,
      response: response,
      redirect: TankScreen(batch: batch),
    );
  }

  dynamic afterRequestAlertDialog({
    context = BuildContext,
    response = dynamic,
    redirect = Widget,
  }) {
    if (response is ErrorModel) {
      return ErrorHandler.getAlertDialogError(context, response.message);
    }
    NavigatorUtils.pushReplacementWithFadeAnimation(context, redirect);
  }

  dynamic afterRequestSnackBar({
    context = BuildContext,
    response = dynamic,
    redirect = Widget,
  }) {
    if (response is ErrorModel) {
      return ErrorHandler.getSnackBarError(context, response.message);
    }
    NavigatorUtils.pushReplacementWithFadeAnimation(context, redirect);
  }

  Future<dynamic> updateTank(
      BuildContext context, TankModel tank, BatchModel batch) async {
    dynamic response =
        await TankService().updateTank(tank, tank.id!, batch.id!);

    return afterRequestAlertDialog(
      context: context,
      response: response,
      redirect: TankScreen(batch: batch),
    );
  }

  Future<TankModel> _generateTank(
      TankModel tankModel,
      tankNameController,
      fishAmounController,
      String speciesDescription,
      double initialWeigth,
      String weitghUnity,
      bool hasTemperature) async {
    tankModel.description = tankNameController.text;
    tankModel.fishAmount = int.parse(fishAmounController.text);
    tankModel.weightUnity = weitghUnity;
    tankModel.initialWeight = initialWeigth;
    tankModel.species =
        await _speciesService.findByDescricao(speciesDescription);
    tankModel.hasTemperatureGauge = hasTemperature;

    return tankModel;
  }

  String resolveOnChaged(
      TextEditingController _controller, bool _submitted, String text) {
    return _controller.text.isEmpty && _submitted
        ? _controller.text = text
        : _controller.text;
  }

  String? resolveErrorText({
    controller = TextEditingController,
    submitted = bool,
    errorMessage = String,
  }) {
    return controller.text.isEmpty && submitted ? errorMessage : null;
  }

  bool isInvalid(
          TextEditingController initialWeightController,
          TextEditingController fishAmounController,
          TextEditingController tankNameController) =>
      initialWeightController.text.isEmpty ||
      fishAmounController.text.isEmpty ||
      tankNameController.text.isEmpty;
}
