import 'package:fishcount_app/model/enums/EnumTipoEmail.dart';

class EmailModel {
  late int id;

  late String descricao;

  late EnumTipoEmail tipoEmail;

  EmailModel(
    this.id,
    this.descricao,
    this.tipoEmail,
  );

  EmailModel.toLocaDatabase(
    this.descricao,
    this.tipoEmail,
  );

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
