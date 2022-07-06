import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/model/enums/EnumTipoPagamento.dart';

class PagamentoModel {
  late int? id;

  late double valor;

  late double saldo;

  late double acrescimo;

  late double desconto;

  late int qtdeParcelas;

  late PlanoModel plano;

  late EnumTipoPagamento tipoPagamento;

  late EnumStatusPagamento statusPagamento;
}
