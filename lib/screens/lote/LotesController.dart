import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/exceptions/ExceptionsMessage.dart';

class LotesController {
  static Widget resolverListaLotes(
      BuildContext context, AsyncSnapshot<List<LoteModel>> snapshot) {
    if (snapshot.hasData) {}
    if (snapshot.connectionState == ConnectionState.done) {
      return _getUsuarioNaoPossuiLotesWidget(context);
    }
    if (snapshot.hasError) {
      return _handleError();
    }
    return _getCircularProgressIndicator();
  }

  static Widget getUserEmail() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.getString("userEmail")!);
        }
        return const Text("");
      },
    );
  }

  static Widget getQtdeLotes(List<LoteModel> lotes) =>
      Text(lotes.length.toString() + " Lotes");

  static Container _getCircularProgressIndicator() {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          semanticsLabel: "Carregando",
        ),
      ),
    );
  }

  static Container _handleError() {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: const Center(
        child: Text(ExceptionsMessage.serverError),
      ),
    );
  }

  static Container _getUsuarioNaoPossuiLotesWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: const Text(
              ExceptionsMessage.usuarioSemLote,
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
                Navigator.pushNamed(context, AppPaths.cadastroLotePath);
              },
            ),
          ),
        ],
      ),
    );
  }
}
