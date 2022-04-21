import 'package:fishcount_app/model/AnaliseModel.dart';

class TanqueModel {
  late int id;

  late String especie;

  late String ultimaAnalise;

  late String proximaAnalise;

  late String dataUltimaAnalise;

  late String dataUltimoTratamento;

  late List<AnaliseModel> analises;

  TanqueModel(
    this.id,
    this.especie,
    this.ultimaAnalise,
    this.proximaAnalise,
    this.dataUltimaAnalise,
    this.dataUltimoTratamento,
  );

  TanqueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    especie = json['especie'];
    ultimaAnalise = json['ultimaAnalise'];
    proximaAnalise = json['proximaAnalise'];
    dataUltimaAnalise = json['dataUltimaAnalise'];
    dataUltimoTratamento = json['dataUltimoTratamento'];
    analises = List<AnaliseModel>.from(json['analises']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "especie": especie,
        "ultimaAnalise": ultimaAnalise,
        "proximaAnalise": proximaAnalise,
        "dataUltimaAnalise": dataUltimaAnalise,
        "dataUltimoTratamento": dataUltimoTratamento,
        "analises": analises
      };
}
