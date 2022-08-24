class PlanModel {
  late int id;

  late String descricao;

  late double valorMinimo;

  late double valorMaximo;

  late int minTanque;

  late int maxTanque;

  late int qtdeParcela;

  PlanModel(
    this.id,
    this.descricao,
    this.valorMinimo,
    this.valorMaximo,
    this.minTanque,
    this.maxTanque,
    this.qtdeParcela,
  );

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valorMinimo = json['valorMinimo'];
    valorMaximo = json['valorMaximo'];
    qtdeParcela = json['qtdeParcela'];
    minTanque = json['minTanque'];
    maxTanque = json['maxTanque'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "valorMinimo": valorMinimo,
        "valorMaximo": valorMaximo,
        "qtdeParcela": qtdeParcela,
        "minTanque": minTanque,
        "maxTanque": maxTanque
      };
}
