import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/screens/financeiro/FinanceiroForm.dart';
import 'package:fishcount_app/screens/financeiro/pagamento/PagamentoScreen.dart';
import 'package:fishcount_app/screens/financeiro/plano/PlanoScreen.dart';
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
        context,
        const FinanceiroForm(),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
        child: Column(
          children: [
            DividerWidget(
              widgetBetween: Text(
                _showPagamentos() ? "Plano Atual" : "Financeiro",
                style: const TextStyle(color: Colors.blue, fontSize: 17),
              ),
              height: 1,
              thikness: 1,
              color: Colors.blue,
              paddingLeft: 12,
              paddingRight: 12,
            ),
            _showPagamentos()
                ? PagamentoScreen.pagamentoList(context, widget.pagamentos!)
                : PlanoScreen.planoList(context),
          ],
        ),
      ),
    );
  }
}
