class PlanModel {
  late int id;

  late String descricao;

  late double valorMinimo;

  late double valorMaximo;

  late double valorParcelaMaximo;

  late double valorParcelaMinimo;

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
    valorParcelaMaximo = json['valorParcelaMaximo'];
    valorParcelaMinimo = json['valorParcelaMinimo'];
    qtdeParcela = json['qtdeParcela'];
    minTanque = json['minTanque'];
    maxTanque = json['maxTanque'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "valorMinimo": valorMinimo,
        "valorParcelaMaximo": valorParcelaMaximo,
        "valorParcelaMinimo": valorParcelaMinimo,
        "valorMaximo": valorMaximo,
        "qtdeParcela": qtdeParcela,
        "minTanque": minTanque,
        "maxTanque": maxTanque
      };
}
