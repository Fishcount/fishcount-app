import 'package:fishcount_app/model/enums/EnumStatusTitulo.dart';
import 'package:fishcount_app/model/enums/EnumTipoTitulo.dart';

class TituloParcelaModel {
  late int id;

  late double valor;

  late double saldo;

  late double acrescimo;

  late double desconto;

  late DateTime dataVencimento;

  late EnumStatusTitulo statusTitulo;

  late EnumTipoTitulo tipoTitulo;
}
