import 'package:fishcount_app/utils/AnimationUtils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
        return 'Análise concluida';

      case 'FALHA_ANALISE':
        return 'Falha na análise';

      default:
        return 'Analise não realizada';

    }
  }

  static dynamic handlerAnimation(String value) {
    switch (value) {
      case 'AGUARDANDO_ANALISE':
        return Container(padding: const EdgeInsets.only(top: 20), child: LoadingAnimationWidget.hexagonDots(color: Colors.blue, size: 30.0),);
      default:
        return null;
    }
  }

  static Color handlerColor(String value) {
    switch (value) {
      case 'ANALISE_NAO_REALIZADA':
        return Colors.black;

      case 'AGUARDANDO_ANALISE':
        return Colors.blue;

      case 'ANALISE_CONCLUIDA':
        return Colors.green;

      case 'FALHA_ANALISE':
        return Colors.red;

      default:
        return Colors.amber;
    }
  }

}