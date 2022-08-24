import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/modules/financial/payment/PaymentController.dart';
import 'package:fishcount_app/modules/financial/plan/PlanController.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/material.dart';

class FinancialScreen extends StatefulWidget {
  final List<PaymentModel>? pagamentos;

  const FinancialScreen({
    Key? key,
    this.pagamentos,
  }) : super(key: key);

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  bool _showPagamentos() {
    return widget.pagamentos != null && widget.pagamentos!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      body: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DividerWidget(
                widgetBetween: Text(
                  _showPagamentos()
                      ? "Planos escolhidos"
                      : "Planos disponíveis",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                height: 1,
                thikness: 2,
                color: Colors.blue,
                paddingLeft: 12,
                paddingRight: 12,
              ),
              _showPagamentos()
                  ? PagamentoController.pagamentoList(context)
                  : PlanController.planoList(context),
            ],
          ),
        ),
      ),
    );
  }
}
