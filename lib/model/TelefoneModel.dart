class TelefoneModel {
  late int? id;

  late String descricao;

  late String tipoTelefone;

  TelefoneModel(
    this.id,
    this.descricao,
    this.tipoTelefone,
  );

  Map<String, dynamic> toLocalDataBase(int idUsuario) => {
        "descricao": descricao,
        "tipoTelefone": tipoTelefone,
        "id_usuario": idUsuario
      };

  TelefoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tipoTelefone = json['tipoTelefone'];
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "descricao": descricao, "tipoTelefone": tipoTelefone};
}
