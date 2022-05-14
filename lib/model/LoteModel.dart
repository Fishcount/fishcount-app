import 'package:fishcount_app/model/TanqueModel.dart';

class LoteModel {
  late int? id;

  late String descricao;

  late List<TanqueModel>? tanques;

  LoteModel(
    this.id,
    this.descricao,
    this.tanques,
  );

  Map<String, dynamic> toLocalDatabase(int idUsuario) =>
      {"descricao": descricao, "id_usuario": idUsuario};

  LoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tanques = json['tanques'] != null
        ? List<TanqueModel>.from(
            json['tanques'].map((x) => TanqueModel.fromJson(x)) ?? const [])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
      };
}
