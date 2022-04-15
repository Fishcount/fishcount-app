import 'package:fishcount_app/model/TaxaCrescimentoModel.dart';

class EspecieModel {
  late int id;

  late String descricao;

  late double pesoMedio;

  late double tamanhoMedio;

  late int qtdeMediaRacao;

  late int diasIntervalo;

  late TaxaCrescimentoModel taxaCrescimento;

  EspecieModel(
    this.id,
    this.descricao,
    this.pesoMedio,
    this.tamanhoMedio,
    this.qtdeMediaRacao,
    this.diasIntervalo,
    this.taxaCrescimento,
  );

  EspecieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    pesoMedio = json['pesoMedio'];
    tamanhoMedio = json['tamanhoMedio'];
    qtdeMediaRacao = json['qtdeMediaRacao'];
    diasIntervalo = json['diasIntervalo'];
    taxaCrescimento = json['taxaCrescimento'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "pesoMedio": pesoMedio,
        "tamanhoMedio": tamanhoMedio,
        "qtdeMediaRacao": qtdeMediaRacao,
        "diasIntervalo": diasIntervalo,
        "taxaCrescimento": taxaCrescimento
      };
}
