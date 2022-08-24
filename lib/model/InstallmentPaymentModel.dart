class InstallmentPaymentModel {
  late int? id;

  late double value;

  late double balance;

  late double discount;

  late double increase;

  late String paymentStatus;

  late String paymentType;

  late String dueDate;

  InstallmentPaymentModel(
    this.id,
    this.value,
    this.balance,
    this.discount,
    this.increase,
    this.paymentStatus,
    this.paymentType,
    this.dueDate,
  );

  InstallmentPaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['valor'];
    balance = json['saldo'];
    increase = json['acrescimo'];
    discount = json['desconto'];
    paymentStatus = json['statusPagamento'];
    paymentType = json['tipoPagamento'];
    dueDate = json['dataVencimento'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "valor": value,
    "saldo": balance,
    "acrescimo": increase,
    "desconto": discount,
    "statusPagamento": paymentStatus,
    "tipoPagamento": paymentType,
    "dataVencimento": dueDate,
  };


}
