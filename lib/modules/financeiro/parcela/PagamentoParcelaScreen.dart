import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/modules/financeiro/parcela/PagamentoParcelaController.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/DrawerWidget.dart';

class PagamentoParcelaScreen extends StatefulWidget {
  final int pagamentId;
  final PlanoModel plano;

  const PagamentoParcelaScreen({
    Key? key,
    required this.pagamentId,
    required this.plano
  }) : super(key: key);

  @override
  State<PagamentoParcelaScreen> createState() => _PagamentoParcelaScreenState();
}

class _PagamentoParcelaScreenState extends State<PagamentoParcelaScreen> {
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
                  style: const TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                height: 1,
                thikness: 2,
                color: Colors.blue,
                paddingLeft: 12,
                paddingRight: 12,
              ),
              PagamentoParcelaController.parcelasList(context, widget.pagamentId)
            ],
          ),
        ),
      ),
    );
  }
}
