import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/repository/EspecieRepository.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/screens/tanque/TanqueForm.dart';
import 'package:fishcount_app/screens/tanque/TanqueScreen.dart';
import 'package:fishcount_app/service/EspecieService.dart';
import 'package:fishcount_app/service/TanqueService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';

class TanqueController extends AbstractController {
  final TextEditingController _pesoMedioController = TextEditingController();
  final TextEditingController _tamanhoMedioController = TextEditingController();
  final TextEditingController _qtdeMediaRacaoController =
      TextEditingController();

  Future<dynamic> saveTanque(
      BuildContext context, TanqueModel tanque, LoteModel lote) async {
    dynamic response = await TanqueService().saveOrUpdateTank(tanque, lote);

    if (response is TanqueModel) {
      NavigatorUtils.pushReplacement(context, TanquesScreen(lote: lote));
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response);
    }
  }

  Widget resolverDadosEspecie(
      AsyncSnapshot<EspecieModel> snapshot, LoteModel lote, BuildContext context) {
    _pesoMedioController.text = _resolverPesoMedio(snapshot);
    _tamanhoMedioController.text = _resolverTamanhoMedio(snapshot);
    _qtdeMediaRacaoController.text = _resolverQtdeMediaRacao(snapshot);
    return AsyncSnapshotHandler(
      asyncSnapshot: snapshot,
      widgetOnError: const Text("Erro"),
      widgetOnWaiting: const CircularProgressIndicator(),
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
                  NavigatorUtils.push(context, TanqueForm(lote: lote));
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

  String _resolverQtdeMediaRacao(AsyncSnapshot<EspecieModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.qtdeMediaRacao.toString() +
        " " +
        snapshot.data!.unidadePesoRacao.toString().toLowerCase() +
        "s";
  }

  String _resolverTamanhoMedio(AsyncSnapshot<EspecieModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.tamanhoMedio.toString() +
        " " +
        snapshot.data!.unidadeTamanho.toString().toLowerCase();
  }

  String _resolverPesoMedio(AsyncSnapshot<EspecieModel> snapshot) {
    if (snapshot.data == null) {
      return "";
    }
    return snapshot.data!.pesoMedio.toString() +
        " " +
        snapshot.data!.unidadePesoMedio.toString().toLowerCase() +
        "s";
  }

  Future<List<EspecieModel>> resolverListaEspecie(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    return isConnected
        ? EspecieService().listarEspecies(context)
        : EspecieRepository().listar(context);
  }
}
