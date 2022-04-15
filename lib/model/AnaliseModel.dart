class AnaliseModel {
  late int id;

  late double qtdeRacao;

  late double pesoMedio;

  late double qtdeMediaracao;

  late DateTime dataAnalise;

  AnaliseModel(
    this.id,
    this.qtdeRacao,
    this.pesoMedio,
    this.qtdeMediaracao,
    this.dataAnalise,
  );

  AnaliseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qtdeRacao = json['qtdeRacao'];
    pesoMedio = json['pesoMedio'];
    qtdeMediaracao = json['qtdeMediaRacao'];
    dataAnalise = json['dataAnalise'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "qtdeRacao": qtdeRacao,
        "pesoMedio": pesoMedio,
        "qtdeMediaRacao": qtdeMediaracao,
        "dataAnalise": dataAnalise
      };
}
