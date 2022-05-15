import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/repository/TanqueRepository.dart';
import 'package:fishcount_app/screens/tanque/TanqueController.dart';
import 'package:fishcount_app/service/TanqueService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
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

  Future<List<TanqueModel>> listarTanques() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return TanqueSerice().listarTanquesFromLote(widget.lote!);
    }
    return TanqueRepository().listarTanques(context, widget.lote!.id!);
  }

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
              const DividerWidget(
                textBetween: "TANQUES",
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.blue,
                textColor: Colors.black,
                isBold: true,
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: listarTanques(),
                    builder:
                        (context, AsyncSnapshot<List<TanqueModel>> snapshot) {
                      return TanqueController()
                          .resolverListaTanques(context, snapshot);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
