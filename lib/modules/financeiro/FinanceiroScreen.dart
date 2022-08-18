import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/modules/financeiro/pagamento/PagamentoController.dart';
import 'package:fishcount_app/modules/financeiro/plano/PlanoController.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
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
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DividerWidget(
                widgetBetween: Text(
                  _showPagamentos()
                      ? "Planos escolhidos"
                      : "Planos disponíveis",
                  style: const TextStyle(color: Colors.blue, fontSize: 17),
                ),
                height: 1,
                thikness: 1,
                color: Colors.blue,
                paddingLeft: 12,
                paddingRight: 12,
              ),
              _showPagamentos()
                  ? PagamentoController.pagamentoList(context)
                  : PlanoController.planoList(context),
            ],
          ),
        ),
      ),
    );
  }
}
