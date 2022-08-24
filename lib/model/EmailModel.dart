class EmailModel {
  late int? id;

  late String email;

  late String emailType;

  EmailModel(
    this.id,
    this.email,
    this.emailType,
  );

  Map<String, dynamic> toLocalDatabase(int userId) => {
        "descricao": email,
        "tipoEmail": emailType,
        "id_usuario": userId,
      };

  EmailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['descricao'];
    emailType = json['tipoEmail'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": email,
        "tipoEmail": emailType,
      };
}
