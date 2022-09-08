import 'package:flutter/material.dart';

enum EnumStatusAnalise {
  ANALISE_NAO_REALIZADA,
  AGUARDANDO_ANALISE,
  ANALISE_CONCLUIDA,
  FALHA_ANALISE,

}

class StatusAnaliseHandler {

  static String handlerText(String value) {
    switch (value) {
      case 'ANALISE_NAO_REALIZADA':
        return 'Analise não realizada';

      case 'AGUARDANDO_ANALISE':
        return 'Aguardando análise';

      case 'ANALISE_CONCLUIDA':
        return 'Análise concluída';

      case 'FALHA_ANALISE':
        return 'Falha na análise';

      default:
        return 'Analise não realizada';

    }
  }

  static Color handlerColor(String value) {
    switch (value) {
      case 'ANALISE_NAO_REALIZADA':
        return Colors.black;

      case 'AGUARDANDO_ANALISE':
        return Colors.teal;

      case 'ANALISE_CONCLUIDA':
        return Colors.green;

      case 'FALHA_ANALISE':
        return Colors.red;

      default:
        return Colors.amber;
    }
  }

}