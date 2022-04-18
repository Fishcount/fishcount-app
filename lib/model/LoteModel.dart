import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';

class LoteModel {
  late int id;

  late String descricao;

  late List<TanqueModel> tanques;

  LoteModel(
    this.id,
    this.descricao,
    this.tanques,
  );

  LoteModel.toLocalDatabase(
    this.descricao,
  );

  LoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    tanques = List<TanqueModel>.from(json['tanques']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "descricao": descricao,
        "tanques": tanques,
      };
}
