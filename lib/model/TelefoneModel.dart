import 'package:fishcount_app/model/enums/EnumTipoTelefone.dart';

class TelefoneModel {
  late int id;

  late String descricao;

  late EnumTipoTelefone tipoTelefone;

  TelefoneModel(
    this.id,
    this.descricao,
    this.tipoTelefone,
  );

  TelefoneModel.toLocalDataBase(
    this.descricao,
    this.tipoTelefone,
  );

  TelefoneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tipoTelefone = json['tipoTelefone'];
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "descricao": descricao, "tipoTelefone": tipoTelefone};
}
