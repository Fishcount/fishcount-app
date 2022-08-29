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
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DividerWidget(
                textBetween:
                    'Plano "' + widget.plano.descricao.toUpperCase() + '"',
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.grey.shade400,
                textColor: Colors.black,
                isBold: true,
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
