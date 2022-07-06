import 'package:fishcount_app/model/TaxaCrescimentoModel.dart';

class EspecieModel {
  late int id;

  late String descricao;

  late double pesoMedio;

  late String unidadePesoMedio;

  late double tamanhoMedio;

  late String unidadeTamanho;

  late int qtdeMediaRacao;

  late String unidadePesoRacao;

  late TaxaCrescimentoModel taxaCrescimento;

  EspecieModel(
    this.id,
    this.descricao,
    this.pesoMedio,
    this.unidadePesoMedio,
    this.tamanhoMedio,
    this.unidadeTamanho,
    this.qtdeMediaRacao,
    this.unidadePesoRacao,
    this.taxaCrescimento,
  );

  EspecieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    pesoMedio = json['pesoMedio'];
    unidadePesoMedio = json['unidadePesoMedio'];
    tamanhoMedio = json['tamanhoMedio'];
    unidadeTamanho = json['unidadeTamanho'];
    qtdeMediaRacao = json['qtdeMediaRacao'];
    unidadePesoRacao = json['unidadePesoRacao'];
    // taxaCrescimento = TaxaCrescimentoModel.fromJson(json["taxaCrescimento"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "pesoMedio": pesoMedio,
        "unidadePesoMedio": unidadePesoMedio,
        "tamanhoMedio": tamanhoMedio,
        "unidadetamanho": unidadeTamanho,
        "qtdeMediaRacao": qtdeMediaRacao,
        "unidadePesoRacao": unidadePesoRacao,
      };
}
