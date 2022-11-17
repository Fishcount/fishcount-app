import 'package:fishcount_app/model/GrowthRateModel.dart';

class SpeciesModel {
  late int id;

  late String description;

  late double averageWeight;

  late String unidadePesoMedio;

  late double tamanhoMedio;

  late String unidadeTamanho;

  late int qtdeMediaRacao;

  late String unidadePesoRacao;

  late GrowthRateModel taxaCrescimento;

  SpeciesModel(
    this.id,
    this.description,
    this.averageWeight,
    this.unidadePesoMedio,
    this.tamanhoMedio,
    this.unidadeTamanho,
    this.qtdeMediaRacao,
    this.unidadePesoRacao,
    this.taxaCrescimento,
  );

  SpeciesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['descricao'];
    averageWeight = json['pesoMedio'];
    unidadePesoMedio = json['unidadePesoMedio'];
    tamanhoMedio = json['tamanhoMedio'];
    unidadeTamanho = json['unidadeTamanho'];
    qtdeMediaRacao = json['qtdeMediaRacao'];
    unidadePesoRacao = json['unidadePesoRacao'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": description,
        "pesoMedio": averageWeight,
        "unidadePesoMedio": unidadePesoMedio,
        "tamanhoMedio": tamanhoMedio,
        "unidadeTamanho": unidadeTamanho,
        "qtdeMediaRacao": qtdeMediaRacao,
        "unidadePesoRacao": unidadePesoRacao,
      };
}
