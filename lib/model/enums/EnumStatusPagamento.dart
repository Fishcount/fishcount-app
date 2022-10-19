import 'dart:ui';

import 'package:flutter/material.dart';

enum EnumStatusPagamento{
  ANALISE,
  ABERTO,
  PAGAMENTO_PARCIAL,
  FINALIZADO,
}


class EnumStatusPagamentoHandler {

  static Color getColorByStatus(String status){
    switch (status) {
      case 'ANALISE':
        return Colors.yellow.shade800;

      case 'ABERTO':
        return Colors.blue;

      case 'PAGAMENTO_PARCIAL':
        return Colors.purple;

      case 'FINALIZADO':
        return Colors.green;

      case 'ATRASADO':
        return Colors.red;

      default:
        return Colors.blue;
    }
  }

}