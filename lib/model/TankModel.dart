import 'package:fishcount_app/model/SpeciesModel.dart';

class TankModel {
  late int? id;

  late String description;

  late int fishAmount;

  late int lastFishAmount;

  late SpeciesModel species;

  late double? initialWeight;

  late String? weightUnity;

  late String? analisyStatus;

  late String? inclusionDate;

  late String? lastAnalysis;

  late String? nextAnalysis;

  late String? nextAnalysisDate;

  late String? lastAnalysisDate;

  late bool hasTemperatureGauge;

  TankModel.empty(this.id);

  TankModel(
    this.id,
    this.description,
    this.fishAmount,
    this.lastFishAmount,
    this.species,
    this.initialWeight,
    this.weightUnity,
    this.analisyStatus,
    this.inclusionDate,
    this.lastAnalysis,
    this.nextAnalysis,
    this.nextAnalysisDate,
    this.lastAnalysisDate,
    this.hasTemperatureGauge,
  );

  TankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['descricao'] ?? "";
    fishAmount = json['qtdePeixe'] ?? 0;
    lastFishAmount = json['qtdUltimaAnalise'] ?? 0;
    initialWeight = json['pesoUnitario'];
    weightUnity = json['unidadePeso'];
    analisyStatus = json['statusAnalise'];
    species = SpeciesModel.fromJson(json['especie']);
    inclusionDate = json['dataInclusao'];
    lastAnalysis = json['ultimaAnalise'];
    nextAnalysis = json['proximaAnalise'];
    nextAnalysisDate = json['dataUltimaAnalise'];
    lastAnalysisDate = json['dataUltimoTratamento'];
    hasTemperatureGauge = json['possuiMedicaoTemperatura'];
  }

  Map<String, dynamic> toLocalDatabase(int speciesId, int batchId) => {
        "descricao": description,
        "qtdePeixes": fishAmount,
        "qtdUltimaAnalise": lastFishAmount,
        "pesoInicial": initialWeight,
        "unidadePeso": weightUnity,
        "statusAnalise": analisyStatus,
        "ultimaAnalise": lastAnalysis,
        "proximaAnalise": nextAnalysis,
        "dataInclusao": inclusionDate,
        "dataUltimaAnalise": nextAnalysisDate,
        "dataUltimoTratamento": lastAnalysisDate,
        "id_especie": speciesId,
        "id_lote": batchId
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": description,
        "qtdePeixe": fishAmount,
        "unidadePeso": weightUnity,
        "pesoUnitario": initialWeight,
        "especie": species,
        "possuiMedicaoTemperatura": hasTemperatureGauge,
      };
}
