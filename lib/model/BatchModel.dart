import 'package:fishcount_app/model/TankModel.dart';

class BatchModel {
  late int? id;

  late String description;

  late List<TankModel>? tanks;

  late String? inclusionDate;

  BatchModel(
    this.id,
    this.description,
    this.tanks,
  );

  Map<String, dynamic> toLocalDatabase(int userId) => {
        "descricao": description,
        "id_usuario": userId,
      };

  BatchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['descricao'];
    inclusionDate = json['dataInclusao'];
    tanks = json['tanques'] != null
        ? List<TankModel>.from(
            json['tanques'].map((x) => TankModel.fromJson(x)) ?? const [])
        : null;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": description,
      };
}
