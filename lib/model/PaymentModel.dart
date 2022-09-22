import 'package:fishcount_app/model/PlanModel.dart';

class PaymentModel {
  int? id;

  late double value;

  late double balance;

  late double increase;

  late double discount;

  late int installmentNumber;

  late PlanModel plan;

  late String paymentType;

  late String paymentStatus;

  late String dueDate;

  late String endValidityDate = "";

  late String startValidityDate = "";

  PaymentModel(
    this.id,
    this.value,
    this.balance,
    this.increase,
    this.discount,
    this.installmentNumber,
    this.dueDate,
    this.plan,
    this.paymentType,
    this.paymentStatus,
  );

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['valor'];
    balance = json['saldo'];
    increase = json['acrescimo'];
    discount = json['desconto'];
    installmentNumber = json['qtdeParcelas'];
    plan = PlanModel.fromJson(json['plano']);
    paymentType = json['tipoPagamento'];
    paymentStatus = json['statusPagamento'];
    dueDate = json['dataVencimento'];
    startValidityDate = json['dataInicioVigencia'];
    endValidityDate = json['dataFimVigencia'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": value,
        "saldo": balance,
        "acrescimo": increase,
        "desconto": discount,
        "qtdeParcelas": installmentNumber,
        "plano": plan,
        "tipoPagamento": paymentType,
        "statusPagamento": paymentStatus,
        "dataVencimento": dueDate,
        "dataInicioVigencia": startValidityDate,
        "dataFimVigencia": endValidityDate,
      };
}
