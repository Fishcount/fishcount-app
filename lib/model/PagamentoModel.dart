import 'package:fishcount_app/model/PlanoModel.dart';

class PagamentoModel {
  late int? id;

  late double valor;

  late double saldo;

  late double acrescimo;

  late double desconto;

  late int qtdeParcelas;

  late PlanoModel plano;

  late String tipoPagamento;

  late String statusPagamento;

  PagamentoModel(
    this.id,
    this.valor,
    this.saldo,
    this.acrescimo,
    this.desconto,
    this.qtdeParcelas,
    this.plano,
    this.tipoPagamento,
    this.statusPagamento,
  );

  PagamentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    saldo = json['saldo'];
    acrescimo = json['acrescimo'];
    desconto = json['desconto'];
    qtdeParcelas = json['qtdeParcelas'];
    // plano = json['plano'].map((plano) => PlanoModel.fromJson(plano));
    tipoPagamento = json['tipoPagamento'];
    statusPagamento = json['statusPagamento'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "saldo": saldo,
        "acrescimo": acrescimo,
        "desconto": desconto,
        "qtdeParcelas": qtdeParcelas,
        "plano": plano,
        "tipoPagamento": tipoPagamento,
        "statusPagamento": statusPagamento,
      };
}
