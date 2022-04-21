import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/lote/LotesController.dart';
import 'package:fishcount_app/screens/lote/LotesService.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotesScreen extends StatefulWidget {
  const LotesScreen({Key? key}) : super(key: key);

  @override
  State<LotesScreen> createState() => _LotesScreenState();
}

class _LotesScreenState extends State<LotesScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<LoteModel> lotes = [];
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int? userId;

  @override
  void initState() {
    prefs.then((value) {
      value.setString("userEmail", "email@teste.com");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(context),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 8),
                    child: LotesController.getUserEmail(),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 8),
                    child: LotesController.getQtdeLotes(lotes),
                  )
                ],
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
                        "Lotes".toUpperCase(),
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
                        future: LotesService().listarLotesUsuario(),
                        builder:
                            (context, AsyncSnapshot<List<LoteModel>> snapshot) {
                          return LotesController.resolverListaLotes(
                              context, snapshot);
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
