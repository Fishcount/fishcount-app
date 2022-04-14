import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusTitulo.dart';
import 'package:fishcount_app/model/enums/EnumTipoTitulo.dart';

class TituloModel {
  late int id;

  late double valor;

  late double saldo;

  late double desconto;

  late DateTime dataVencimento;

  late EnumStatusTitulo statusTitulo;

  late EnumTipoTitulo tipoTitulo;

  late int qtdeParcelas;

  late PlanoModel plano;
}
