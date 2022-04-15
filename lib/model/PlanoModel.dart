class PlanoModel {
  late int id;

  late String descricao;

  late double valorMinimo;

  late double valorMaximo;

  late int minTanque;

  late int maxTanque;

  PlanoModel(
    this.id,
    this.descricao,
    this.valorMinimo,
    this.valorMaximo,
    this.minTanque,
    this.maxTanque,
  );

  PlanoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valorMinimo = json['valorMinimo'];
    valorMaximo = json['valorMaximo'];
    minTanque = json['minTanque'];
    maxTanque = json['maxTanque'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "valorMinimo": valorMinimo,
        "valorMaximo": valorMaximo,
        "minTanque": minTanque,
        "maxTanque": maxTanque
      };
}
