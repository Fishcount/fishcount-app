class LoteModel {
  late int? id;

  late String descricao;

  LoteModel(
    this.id,
    this.descricao,
  );

  LoteModel.toLocalDatabase(
    this.descricao,
  );

  LoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
      };
}
