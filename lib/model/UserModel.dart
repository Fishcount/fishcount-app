import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';

class UserModel {
  late int id;

  late String nome;

  late String senha;

  late List<TelefoneModel> telefones;

  late List<EmailModel> emails;

  late List<LoteModel> lotes;

  UserModel(
    this.id,
    this.nome,
    this.senha,
    this.telefones,
    this.emails,
    this.lotes,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    telefones = List<TelefoneModel>.from(json['telefones']);
    emails = List<EmailModel>.from(json['emails']);
    lotes = List<LoteModel>.from(json['lotes']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "senha": senha,
        "telefones": telefones,
        "email": emails,
        "lotes": lotes
      };
}
