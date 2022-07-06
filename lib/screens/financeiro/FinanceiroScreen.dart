import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/screens/lote/LotesController.dart';
import 'package:fishcount_app/service/LotesService.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

class FinanceiroScreen extends StatefulWidget {
  const FinanceiroScreen({Key? key}) : super(key: key);

  @override
  State<FinanceiroScreen> createState() => _FinanceiroScreenState();
}
Future<List<LoteModel>>? listarLotes(BuildContext context) async {
  bool isConnected = await ConnectionUtils().isConnected();
  if (isConnected) {
    return LotesService().listarLotesUsuario();
  }
  return LoteRepository().listarLotesUsuario(context);
}
class _FinanceiroScreenState extends State<FinanceiroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          children: [
            const DividerWidget(
              widgetBetween: Text(
                "Financeiro",
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
              height: 1,
              thikness: 1,
              color: Colors.blue,
              paddingLeft: 12,
              paddingRight: 12,
            ),
            SingleChildScrollView(
              child: FutureBuilder(
                future: listarLotes(context),
                builder: (context, AsyncSnapshot<List<LoteModel>> snapshot) {
                  return LotesController()
                      .resolverListaLotes(context, snapshot);
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
