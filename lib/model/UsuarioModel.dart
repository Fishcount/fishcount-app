import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';

class UsuarioModel {
  late int? id;

  late String nome;

  late String senha;

  late String email;

  late String telefone;

  late List<TelefoneModel> telefones;

  late List<EmailModel> emails;

  late List<LoteModel> lotes;

  UsuarioModel(
    this.id,
    this.nome,
    this.senha,
    this.telefones,
    this.emails,
    this.lotes,
  );

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    telefones = List<TelefoneModel>.from(
        json['telefones'].map((telefone) => TelefoneModel.fromJson(telefone)) ??
            const []);
    emails = List<EmailModel>.from(
        json['emails'].map((email) => EmailModel.fromJson(email)) ?? const []);
    lotes = List<LoteModel>.from(
        json['lotes'].map((lote) => LoteModel.fromJson(lote)) ?? const []);
  }

  UsuarioModel.fromDatabase(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "senha": senha,
        "telefones": telefones.map((e) => e.toJson()).toList(),
        "emails": emails.map((e) => e.toJson()).toList(),
        "lotes": lotes.map((e) => e.toJson()).toList()
      };

  Map<String, dynamic> toLocalDataBase() => {
        "nome": nome,
        "email": emails.first.descricao,
        "senha": senha,
      };
}
