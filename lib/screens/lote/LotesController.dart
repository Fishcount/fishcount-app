import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/lote/CadastroLoteScreen.dart';
import 'package:fishcount_app/screens/tanque/TanqueScreen.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/exceptions/ExceptionsMessage.dart';

class LotesController {
  static Widget resolverListaLotes(
      BuildContext context, AsyncSnapshot<List<LoteModel>> snapshot) {
    if (snapshot.hasData) {
      return _listaLotes(context, snapshot.data!);
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return _getUsuarioNaoPossuiLotesWidget(context);
    }
    if (snapshot.hasError) {
      return _handleError();
    }
    return _getCircularProgressIndicator();
  }

  static Widget _listaLotes(BuildContext context, List<LoteModel> lotes) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Container(
            child: ListView.builder(
              itemCount: lotes.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getEditIcon(context, lotes[index]),
                      _getNomeLote(context, lotes[index]),
                      _getTrashIcon()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  static GestureDetector _getNomeLote(
      BuildContext context, LoteModel loteModel) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TanquesScreen(loteId: loteModel.id),
        ),
      ),
      child: Text(
        loteModel.descricao.toUpperCase(),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  static Container _getEditIcon(BuildContext context, LoteModel loteModel) {
    return Container(
      padding: const EdgeInsets.only(left: 7),
      child: GestureDetector(
        child: const Icon(
          LineIcons.edit,
          color: Colors.black,
          size: 30,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroLoteScreen(lote: loteModel),
            ),
          );
        },
      ),
    );
  }

  static Container _getTrashIcon() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: GestureDetector(
        child: const Icon(
          LineIcons.alternateTrash,
          size: 30,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }

  static Widget getUserEmail() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.getString("userEmail")!,
            style: TextStyle(fontSize: 16),
          );
        }
        return const Text("");
      },
    );
  }

  static Widget getQtdeLotes(List<LoteModel> lotes) {
    String controlarLotes = lotes.length > 1 ? "s" : "";
    return Text(lotes.length.toString() + " Lote" + controlarLotes);
  }

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
