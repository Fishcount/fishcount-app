class EmailModel {
  late int? id;

  late String descricao;

  late String tipoEmail;

  EmailModel(
    this.id,
    this.descricao,
    this.tipoEmail,
  );

  Map<String, dynamic> toLocalDatabase(int idUsuario) =>
      {"descricao": descricao, "tipoEmail": tipoEmail, "id_usuario": idUsuario};

  EmailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tipoEmail = json['tipoEmail'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "tipoEmail": tipoEmail,
      };
}
