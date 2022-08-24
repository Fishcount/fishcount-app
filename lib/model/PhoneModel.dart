class PhoneModel {
  late int? id;

  late String phoneNumber;

  late String phoneType;

  PhoneModel(
    this.id,
    this.phoneNumber,
    this.phoneType,
  );

  Map<String, dynamic> toLocalDataBase(int userId) => {
        "descricao": phoneNumber,
        "tipoTelefone": phoneType,
        "id_usuario": userId
      };

  PhoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['descricao'];
    phoneType = json['tipoTelefone'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": phoneNumber,
        "tipoTelefone": phoneType,
      };
}
