import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/screens/plano/PlanoController.dart';
import 'package:fishcount_app/service/PlanoService.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

class FinanceiroScreen extends StatefulWidget {
  final List<PagamentoModel>? pagamentos;

  const FinanceiroScreen({
    Key? key,
    this.pagamentos,
  }) : super(key: key);

  @override
  State<FinanceiroScreen> createState() => _FinanceiroScreenState();
}

class _FinanceiroScreenState extends State<FinanceiroScreen> {
  bool _showPagamentos() {
    return widget.pagamentos != null && widget.pagamentos!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomSheet: CustomBottomSheet.getCustomBottomSheet(
          context, AppPaths.cadastroLotePath),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
        child: Column(
          children: [
            DividerWidget(
              widgetBetween: Text(
                _showPagamentos() ? "Pagamentos" : "Financeiro",
                style: const TextStyle(color: Colors.blue, fontSize: 17),
              ),
              height: 1,
              thikness: 1,
              color: Colors.blue,
              paddingLeft: 12,
              paddingRight: 12,
            ),
            _showPagamentos()
                ? Text("Pagamentos")
                : SingleChildScrollView(
                    child: FutureBuilder(
                      future: PlanoService().listarPlanos(),
                      builder:
                          (context, AsyncSnapshot<List<PlanoModel>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          if (snapshot.hasData && snapshot.data!.isEmpty) {
                            return const Text(
                                "Não foi possível encontrar nenhum plano disponivel");
                          }
                          return PlanoController()
                              .listarPlanos(snapshot.data!, context);
                        }
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
