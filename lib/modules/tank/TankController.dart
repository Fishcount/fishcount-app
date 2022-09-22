import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/SpeciesModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/repository/EspecieRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../../utils/AnimationUtils.dart';
import '../generic/AbstractController.dart';
import '../species/SpecieService.dart';
import 'TankForm.dart';
import 'TankScreen.dart';
import 'TankService.dart';

class TankController extends AbstractController {
  final SpeciesService _speciesService = SpeciesService();
  final TankService _tankService = TankService();

  final TextEditingController _pesoMedioController = TextEditingController();
  final TextEditingController _tamanhoMedioController = TextEditingController();
  final TextEditingController _qtdeMediaRacaoController =
      TextEditingController();

  Future<dynamic> saveTank(
      BuildContext context, TankModel tank, BatchModel batch) async {
    dynamic response = await _tankService.saveTank(tank, batch.id!);

    return validateResponse(
      context: context,
      response: response,
      redirect: TankScreen(batch: batch),
    );
  }

  Future<dynamic> updateTank(
      BuildContext context, TankModel tank, BatchModel batch) async {
    dynamic response =
        await TankService().updateTank(tank, tank.id!, batch.id!);

    return validateResponse(
      context: context,
      response: response,
      redirect: TankScreen(batch: batch),
    );
  }

  openTankRegisterModal(
      BuildContext context,
      TextEditingController _tankNameController,
      TextEditingController fishAmounController,
      TextEditingController initialWeightController,
      String tankSpecie,
      AnimationController animationController,
      TankModel? tankModel,
      BatchModel batchModel) async {
    final bool _isUpdate = tankModel != null;
    bool? hasTemperature = false;
    final List<SpeciesModel> species = await resolverListaEspecie(context);
    bool _submitted = false;
    bool loading = false;
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
                    controller: _tankNameController,
                    hintText: 'Nome do tanque',
                    focusedBorderColor: Colors.blueGrey,
                    iconColor: Colors.blueGrey,
                    obscureText: false,
                    labelText: 'Nome do tanque',
                    errorText: resolveErrorText(
                      controller: _tankNameController,
                      submitted: _submitted,
                      errorMessage: 'O nome do tanque não pode estar vazio.',
                    ),
                    onChanged: (text) => setState(() =>
                        resolveOnChaged(_tankNameController, _submitted, text)),
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
                    keyBoardType: TextInputType.number,
                    errorText: resolveErrorText(
                        controller: fishAmounController,
                        submitted: _submitted,
                        errorMessage:
                            'A quantidade de peixes não pode estar vazia.'),
                    onChanged: (text) => setState(
                      () => resolveOnChaged(
                          fishAmounController, _submitted, text),
                    ),
                  ),
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
                        labelText: 'Peso inicial dos peixes',
                        keyBoardType: TextInputType.number,
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
                    value: hasTemperature,
                    onChanged: (newValue) {
                      setState(() => hasTemperature = newValue);
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                loading
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
                                if (!_isFormValid(initialWeightController,
                                    fishAmounController, _tankNameController)) {
                                  return;
                                }
                                setState(() => loading = true);
                                return await _confirmTank(
                                  tankSpecie,
                                  species,
                                  _isUpdate,
                                  tankModel,
                                  batchModel,
                                  _tankNameController,
                                  fishAmounController,
                                  initialWeightController,
                                  isGrams ? 'GRAMA' : 'KILO',
                                  context,
                                  hasTemperature!,
                                );
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

  bool _isFormValid(
          TextEditingController initialWeightController,
          TextEditingController fishAmounController,
          TextEditingController tankNameController) =>
      initialWeightController.text.isNotEmpty &&
          fishAmounController.text.isNotEmpty ||
      tankNameController.text.isNotEmpty;

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

  Widget resolveSpecieData(AsyncSnapshot<SpeciesModel> snapshot,
      BatchModel batch, BuildContext context) {
    _pesoMedioController.text = _resolverPesoMedio(snapshot);
    _tamanhoMedioController.text = _resolverTamanhoMedio(snapshot);
    _qtdeMediaRacaoController.text = _resolverQtdeMediaRacao(snapshot);
    return AsyncSnapshotHandler(
      asyncSnapshot: snapshot,
      widgetOnError: const Text("Erro"),
      widgetOnWaiting: Container(
        padding: const EdgeInsets.only(top: 30),
        child: AnimationUtils.progressiveDots(size: 50.0),
      ),
      widgetOnEmptyResponse: Container(
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
                  NavigatorUtils.push(context, TankForm(batch: batch));
                },
              ),
            ),
          ],
        ),
      ),
      widgetOnSuccess: _speciesData(context),
    ).handler();
  }

  Widget _speciesData(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 160,
                height: 200,
                child: Image.asset(ImagePaths.imageLogo),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFieldWidget(
                        labelText: "Peso Médio",
                        controller: _pesoMedioController,
                        hintText: _pesoMedioController.text,
                        focusedBorderColor: Colors.blue,
                        iconColor: Colors.blue,
                        obscureText: false,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 200,
                        child: TextFieldWidget(
                          labelText: "Tamanho Médio",
                          controller: _tamanhoMedioController,
                          hintText: _tamanhoMedioController.text,
                          focusedBorderColor: Colors.blue,
                          iconColor: Colors.blue,
                          obscureText: false,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 200,
                        child: TextFieldWidget(
                          labelText: "Media Ração",
                          controller: _qtdeMediaRacaoController,
                          hintText: _qtdeMediaRacaoController.text,
                          focusedBorderColor: Colors.blue,
                          iconColor: Colors.blue,
                          obscureText: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _resolverQtdeMediaRacao(AsyncSnapshot<SpeciesModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.qtdeMediaRacao.toString() +
        " " +
        snapshot.data!.unidadePesoRacao.toString().toLowerCase() +
        "s";
  }

  String _resolverTamanhoMedio(AsyncSnapshot<SpeciesModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.tamanhoMedio.toString() +
        " " +
        snapshot.data!.unidadeTamanho.toString().toLowerCase();
  }

  String _resolverPesoMedio(AsyncSnapshot<SpeciesModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.averageWeight.toString() +
        " " +
        snapshot.data!.unidadePesoMedio.toString().toLowerCase() +
        "s";
  }

  Future<List<SpeciesModel>> resolverListaEspecie(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    return isConnected
        ? SpeciesService().listarEspecies(context)
        : EspecieRepository().listar(context);
  }

  Widget speciesList(
      BuildContext context,
      AsyncSnapshot<List<SpeciesModel>> snapshot,
      String firstValue,
      dynamic Function(String?)? function) {
    if (snapshot.data == null) {
      return Text("");
    }

    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromARGB(232, 232, 232, 232),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: DropdownButton<String>(
        value: firstValue,
        isExpanded: true,
        items: snapshot.data!
            .map(
              (especie) => DropdownMenuItem(
                value: especie.description,
                child: Text(especie.description),
              ),
            )
            .toList(),
        onChanged: function,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
