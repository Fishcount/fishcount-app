import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/SpeciesModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AppBarBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/BatchModel.dart';
import '../species/SpecieService.dart';
import 'TankController.dart';

class TankForm extends StatefulWidget {
  final TankModel? tank;
  final BatchModel batch;

  const TankForm({
    Key? key,
    this.tank,
    required this.batch,
  }) : super(key: key);

  @override
  State<TankForm> createState() => _TankFormState();
}


class _TankFormState extends State<TankForm> {
  final TextEditingController _nomeTanqueController = TextEditingController();
  final TextEditingController _qtdePeixesController = TextEditingController();

  String descricaoEspecie = "";
  SpeciesModel? especieModel;

  @override
  Widget build(BuildContext context) {
    _nomeTanqueController.text = widget.tank != null
        ? widget.tank!.description
        : _nomeTanqueController.text;

    _qtdePeixesController.text = widget.tank != null
        ? widget.tank!.fishAmount.toString()
        : _qtdePeixesController.text;
    return Scaffold(
      appBar:  AppBarBuilder().build(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  widget.tank != null
                      ? widget.tank!.description
                      : "Novo Tanque",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _nomeTanqueController,
                  hintText: "Nome do Tanque",
                  prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                  focusedBorderColor: Colors.blueGrey,
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: TextFieldWidget(
                  controller: _qtdePeixesController,
                  hintText: "Quantidade inicial de peixes",
                  prefixIcon: const Icon(Icons.numbers),
                  focusedBorderColor: Colors.blueGrey,
                  iconColor: Colors.blueGrey,
                  obscureText: false,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFieldWidget(
                      controller: _qtdePeixesController,
                      hintText: "Peso inicial",
                      prefixIcon: const Icon(Icons.numbers),
                      focusedBorderColor: Colors.blueGrey,
                      iconColor: Colors.blueGrey,
                      obscureText: false,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder(
                  future: TankController().resolverListaEspecie(context),
                  builder:
                      (context, AsyncSnapshot<List<SpeciesModel>> snapshot) {
                    return AsyncSnapshotHandler(
                      asyncSnapshot: snapshot,
                      widgetOnError: const Text("Erro"),
                      widgetOnWaiting: const CircularProgressIndicator(),
                      widgetOnEmptyResponse: _onEmptyResponse(context),
                      widgetOnSuccess: speciesList(context, snapshot),
                    ).handler();
                  },
                ),
              ),
              descricaoEspecie == ""
                  ? FutureBuilder(
                      future: SpeciesService().findFirst(),
                      builder: (context, AsyncSnapshot<SpeciesModel> snapshot) {
                        especieModel = snapshot.data;
                        return TankController().resolveSpecieData(
                            snapshot, widget.batch, context);
                      },
                    )
                  : FutureBuilder(
                      future:
                          SpeciesService().findByDescricao(descricaoEspecie),
                      builder: (context, AsyncSnapshot<SpeciesModel> snapshot) {
                        especieModel = snapshot.data;
                        return TankController().resolveSpecieData(
                            snapshot, widget.batch, context);
                      },
                    ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButtonWidget(
                  buttonText: "Cadastrar",
                  textSize: 20,
                  radioBorder: 20,
                  horizontalPadding: 30,
                  verticalPadding: 20,
                  textColor: Colors.white,
                  buttonColor: Colors.blue,
                  onPressed: () async => await _saveTank(context, widget.tank),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTank(BuildContext context, TankModel? tanqueModel) async {
    int? id;
    if (tanqueModel != null){
      id = tanqueModel.id;
    }
    final TankModel tanque = TankModel(
        id,
        _nomeTanqueController.text,
        int.parse(_qtdePeixesController.text),
        int.parse(_qtdePeixesController.text),
        especieModel!,
        20.0,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        false);

    await TankController().saveTank(context, tanque, widget.batch);
  }

  Widget _onEmptyResponse(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: const Text(
              "Você não possui nenhum lote cadastrado ainda!",
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
                NavigatorUtils.push(context, TankForm(batch: widget.batch));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget speciesList(
      BuildContext context, AsyncSnapshot<List<SpeciesModel>> snapshot) {
    if (snapshot.data == null) {
      return Text("");
    }
    String firstValue = _resolveFirstValue(snapshot);
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
          onChanged: (String? novoItemSelecionado) {
            setState(() {
              descricaoEspecie = novoItemSelecionado ?? "";
            });
          }),
    );
  }

  String _resolveFirstValue(AsyncSnapshot<List<SpeciesModel>> snapshot) {
    return descricaoEspecie != ""
        ? descricaoEspecie
        : snapshot.data != null
            ? snapshot.data!.first.description
            : "";
  }
}
