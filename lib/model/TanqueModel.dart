class TanqueModel {
  late int id;

  late String descricao;

  late String? ultimaAnalise;

  late String? proximaAnalise;

  late String? dataUltimaAnalise;

  late String? dataUltimoTratamento;

  TanqueModel(
    this.id,
    this.descricao,
    this.ultimaAnalise,
    this.proximaAnalise,
    this.dataUltimaAnalise,
    this.dataUltimoTratamento,
  );

  TanqueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    ultimaAnalise = json['ultimaAnalise'];
    proximaAnalise = json['proximaAnalise'];
    dataUltimaAnalise = json['dataUltimaAnalise'];
    dataUltimoTratamento = json['dataUltimoTratamento'];
  }

  Map<String, dynamic> toLocalDatabase(int idEspecie, int idLote) => {
    "descricao": descricao,
    "ultimaAnalise": ultimaAnalise,
    "proximaAnalise": proximaAnalise,
    "dataUltimaAnalise": dataUltimaAnalise,
    "dataUltimoTratamento": dataUltimoTratamento,
    "id_especie": idEspecie,
    "id_lote": idLote
  };

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "ultimaAnalise": ultimaAnalise,
        "proximaAnalise": proximaAnalise,
        "dataUltimaAnalise": dataUltimaAnalise,
        "dataUltimoTratamento": dataUltimoTratamento,
      };
}
