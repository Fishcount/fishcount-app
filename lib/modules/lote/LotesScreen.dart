import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

import 'LoteForm.dart';
import 'LotesController.dart';
import 'LotesService.dart';

class LotesScreen extends StatefulWidget {
  final AuthUserModel? authUserModel;

  const LotesScreen({Key? key, this.authUserModel}) : super(key: key);

  @override
  State<LotesScreen> createState() => _LotesScreenState();
}

class _LotesScreenState extends State<LotesScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<LoteModel> lotes = [];

  Future<List<LoteModel>>? listarLotes(BuildContext context) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return LotesService().listarLotesUsuario();
    }
    return LoteRepository().listarLotesUsuario(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar:
          CustomBottomSheet.getCustomBottomSheet(context, const LoteForm()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
              textBetween: "LOTES",
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
                  future: listarLotes(context),
                  builder: (context, AsyncSnapshot<List<LoteModel>> snapshot) {
                    return LotesController()
                        .resolverListaLotes(context, snapshot);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
