import 'package:fishcount_app/model/PlanModel.dart';
import 'package:fishcount_app/modules/financial/installment/PaymentInstallmentController.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentInstallmentScreen extends StatefulWidget {
  final int pagamentId;
  final PlanModel plano;

  const PaymentInstallmentScreen(
      {Key? key, required this.pagamentId, required this.plano})
      : super(key: key);

  @override
  State<PaymentInstallmentScreen> createState() =>
      _PaymentInstallmentScreenState();
}

class _PaymentInstallmentScreenState extends State<PaymentInstallmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      body: Container(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DividerWidget(
                widgetBetween: Text(
                  'Plano "' + widget.plano.descricao.toUpperCase() + '"',
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
              PaymentInstallmentController.parcelasList(
                  context, widget.pagamentId)
            ],
          ),
        ),
      ),
    );
  }
}
