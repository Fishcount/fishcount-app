import 'package:fishcount_app/model/TankModel.dart';

class BatchModel {
  late int? id;

  late String descricao;

  late List<TankModel>? tanques;

  BatchModel(
    this.id,
    this.descricao,
    this.tanques,
  );

  Map<String, dynamic> toLocalDatabase(int userId) => {
        "descricao": descricao,
        "id_usuario": userId,
      };

  BatchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tanques = json['tanques'] != null
        ? List<TankModel>.from(
            json['tanques'].map((x) => TankModel.fromJson(x)) ?? const [])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
      };
}
