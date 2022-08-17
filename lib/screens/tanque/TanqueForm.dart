import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/screens/tanque/TanqueController.dart';
import 'package:fishcount_app/service/EspecieService.dart';
import 'package:fishcount_app/service/TanqueService.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/LoteModel.dart';

class TanqueForm extends StatefulWidget {
  final TanqueModel? tanque;
  final LoteModel lote;

  const TanqueForm({
    Key? key,
    this.tanque,
    required this.lote,
  }) : super(key: key);

  @override
  State<TanqueForm> createState() => _TanqueFormState();
}


class _TanqueFormState extends State<TanqueForm> {
  final TextEditingController _nomeTanqueController = TextEditingController();
  final TextEditingController _qtdePeixesController = TextEditingController();

  String descricaoEspecie = "";
  EspecieModel? especieModel;

  @override
  Widget build(BuildContext context) {
    _nomeTanqueController.text = widget.tanque != null
        ? widget.tanque!.descricao
        : _nomeTanqueController.text;

    _qtdePeixesController.text = widget.tanque != null
        ? widget.tanque!.qtdePeixe.toString()
        : _qtdePeixesController.text;
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
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
                  widget.tanque != null
                      ? widget.tanque!.descricao
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
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder(
                  future: TanqueController().resolverListaEspecie(context),
                  builder:
                      (context, AsyncSnapshot<List<EspecieModel>> snapshot) {
                    return AsyncSnapshotHandler(
                      asyncSnapshot: snapshot,
                      widgetOnError: const Text("Erro"),
                      widgetOnWaiting: const CircularProgressIndicator(),
                      widgetOnEmptyResponse: _onEmptyResponse(context),
                      widgetOnSuccess: _speciesList(context, snapshot),
                    ).handler();
                  },
                ),
              ),
              descricaoEspecie == ""
                  ? FutureBuilder(
                      future: EspecieService().findFirst(),
                      builder: (context, AsyncSnapshot<EspecieModel> snapshot) {
                        especieModel = snapshot.data;
                        return TanqueController().resolverDadosEspecie(
                            snapshot, widget.lote, context);
                      },
                    )
                  : FutureBuilder(
                      future:
                          EspecieService().findByDescricao(descricaoEspecie),
                      builder: (context, AsyncSnapshot<EspecieModel> snapshot) {
                        especieModel = snapshot.data;
                        return TanqueController().resolverDadosEspecie(
                            snapshot, widget.lote, context);
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
                  onPressed: () async => await _saveTank(context, widget.tanque),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveTank(BuildContext context, TanqueModel? tanqueModel) async {
    int? id;
    if (tanqueModel != null){
      id = tanqueModel.id;
    }
    final TanqueModel tanque = TanqueModel(
        id,
        _nomeTanqueController.text,
        int.parse(_qtdePeixesController.text),
        especieModel!,
        null,
        null,
        null,
        null);

    await TanqueController().saveTanque(context, tanque, widget.lote);
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
                NavigatorUtils.push(context, TanqueForm(lote: widget.lote));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _speciesList(
      BuildContext context, AsyncSnapshot<List<EspecieModel>> snapshot) {
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
                  value: especie.descricao,
                  child: Text(especie.descricao),
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

  String _resolveFirstValue(AsyncSnapshot<List<EspecieModel>> snapshot) {
    return descricaoEspecie != ""
        ? descricaoEspecie
        : snapshot.data != null
            ? snapshot.data!.first.descricao
            : "";
  }
}
