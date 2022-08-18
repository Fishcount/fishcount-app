class PagamentoParcelaModel {
  late int? id;

  late double valor;

  late double saldo;

  late double desconto;

  late double acrescimo;

  late String statusPagamento;

  late String tipoPagamento;

  late String dataVencimento;

  PagamentoParcelaModel(
    this.id,
    this.valor,
    this.saldo,
    this.desconto,
    this.acrescimo,
    this.statusPagamento,
    this.tipoPagamento,
    this.dataVencimento,
  );

  PagamentoParcelaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    saldo = json['saldo'];
    acrescimo = json['acrescimo'];
    desconto = json['desconto'];
    statusPagamento = json['statusPagamento'];
    tipoPagamento = json['tipoPagamento'];
    dataVencimento = json['dataVencimento'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "valor": valor,
    "saldo": saldo,
    "acrescimo": acrescimo,
    "desconto": desconto,
    "statusPagamento": statusPagamento,
    "tipoPagamento": tipoPagamento,
    "dataVencimento": dataVencimento,
  };


}
