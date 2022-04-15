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

  TituloParcelaModel(
    this.id,
    this.valor,
    this.saldo,
    this.acrescimo,
    this.desconto,
    this.dataVencimento,
    this.statusTitulo,
    this.tipoTitulo,
  );

  TituloParcelaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valor = json['valor'];
    saldo = json['saldo'];
    acrescimo = json['acrescimo'];
    desconto = json['desconto'];
    dataVencimento = json['dataVencimento'];
    statusTitulo = json['statusTitulo'];
    tipoTitulo = json['tipoTitulo'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "valor": valor,
        "saldo": saldo,
        "acrescimo": acrescimo,
        "desconto": desconto,
        "dataVencimento": dataVencimento,
        "statusTitulo": statusTitulo,
        "tipoTitulo": tipoTitulo,
      };
}
