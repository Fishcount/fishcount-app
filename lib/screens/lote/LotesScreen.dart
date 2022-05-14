import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/lote/LotesController.dart';
import 'package:fishcount_app/service/LotesService.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

class LotesScreen extends StatefulWidget {
  final AuthUserModel? authUserModel;

  const LotesScreen({Key? key, this.authUserModel}) : super(key: key);

  @override
  State<LotesScreen> createState() => _LotesScreenState();
}

class _LotesScreenState extends State<LotesScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<LoteModel> lotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
          context, AppPaths.cadastroLotePath),
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
                  future: LotesService().listarLotesUsuario(),
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
