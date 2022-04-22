import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/screens/tanque/TanqueController.dart';
import 'package:fishcount_app/screens/tanque/TanqueService.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TanquesScreen extends StatefulWidget {
  final LoteModel? lote;

  const TanquesScreen({Key? key, this.lote}) : super(key: key);

  @override
  State<TanquesScreen> createState() => _TanquesScreenState();
}

class _TanquesScreenState extends State<TanquesScreen> {
  final TextEditingController _pesquisaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
          context, AppPaths.cadastroTanquePath),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            children: [
              TextFieldWidget(
                controller: _pesquisaController,
                focusedBorderColor: Colors.white30,
                iconColor: Colors.blueGrey,
                prefixIcon: const Icon(Icons.search),
                hintText: "Pesquisar",
                obscureText: false,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Tanques".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: FutureBuilder(
                        future:
                            TanqueSerice().listarTanquesFromLote(widget.lote!),
                        builder: (context,
                            AsyncSnapshot<List<TanqueModel>> snapshot) {
                          return TanqueController()
                              .resolverListaLotes(context, snapshot);
                        },
                      ),
                    )
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
