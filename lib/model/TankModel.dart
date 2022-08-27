import 'package:fishcount_app/model/SpeciesModel.dart';

class TankModel {
  late int? id;

  late String description;

  late int fishAmount;

  late SpeciesModel species;

  late String? lastAnalysis;

  late String? nextAnalysis;

  late String? nextAnalysisDate;

  late String? lastAnalysisDate;

  TankModel.empty(
      this.id
      );

  TankModel(
    this.id,
    this.description,
    this.fishAmount,
    this.species,
    this.lastAnalysis,
    this.nextAnalysis,
    this.nextAnalysisDate,
    this.lastAnalysisDate,
  );

  TankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['descricao'];
    fishAmount = json['qtdePeixe'];
    species = SpeciesModel.fromJson(json['especie']);
    lastAnalysis = json['ultimaAnalise'];
    nextAnalysis = json['proximaAnalise'];
    nextAnalysisDate = json['dataUltimaAnalise'];
    lastAnalysisDate = json['dataUltimoTratamento'];
  }

  Map<String, dynamic> toLocalDatabase(int speciesId, int batchId) => {
    "descricao": description,
    "qtdePeixes": fishAmount,
    "ultimaAnalise": lastAnalysis,
    "proximaAnalise": nextAnalysis,
    "dataUltimaAnalise": nextAnalysisDate,
    "dataUltimoTratamento": lastAnalysisDate,
    "id_especie": speciesId,
    "id_lote": batchId
  };

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": description,
        "qtdePeixe": fishAmount,
        "especie": species
      };
}
