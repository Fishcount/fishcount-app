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

  TituloModel(
    this.id,
    this.valor,
    this.saldo,
    this.desconto,
    this.dataVencimento,
    this.statusTitulo,
    this.tipoTitulo,
    this.qtdeParcelas,
    this.plano,
  );

  TituloModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    saldo = json['saldo'];
    desconto = json['desconto'];
    dataVencimento = json['dataVencimento'];
    statusTitulo = json['statusTitulo'];
    tipoTitulo = json['tipoTitulo'];
    qtdeParcelas = json['qtdeParcelas'];
    plano = json['plano'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "saldo": saldo,
        "desconto": desconto,
        "dataVencimento": dataVencimento,
        "statusTitulo": statusTitulo,
        "tipoTitulo": tipoTitulo,
        "qtdeParcelas": qtdeParcelas,
        "plano": plano,
      };
}
