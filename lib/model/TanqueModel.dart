import 'package:fishcount_app/model/AnaliseModel.dart';

class TanqueModel {
  late int id;

  late String descricao;

  late String especie;

  late String ultimaAnalise;

  late String proximaAnalise;

  late String dataUltimaAnalise;

  late String dataUltimoTratamento;

  late List<AnaliseModel> analises;

  TanqueModel(
    this.id,
    this.descricao,
    this.especie,
    this.ultimaAnalise,
    this.proximaAnalise,
    this.dataUltimaAnalise,
    this.dataUltimoTratamento,
  );

  TanqueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    especie = json['especie'];
    descricao = json['descricao'];
    ultimaAnalise = json['ultimaAnalise'];
    proximaAnalise = json['proximaAnalise'];
    dataUltimaAnalise = json['dataUltimaAnalise'];
    dataUltimoTratamento = json['dataUltimoTratamento'];
    analises = List<AnaliseModel>.from(json['analises']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "especie": especie,
        "descricao": descricao,
        "ultimaAnalise": ultimaAnalise,
        "proximaAnalise": proximaAnalise,
        "dataUltimaAnalise": dataUltimaAnalise,
        "dataUltimoTratamento": dataUltimoTratamento,
        "analises": analises
      };
}
