import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/EnderecoModel.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TelefoneModel.dart';

class PessoaModel {
  late int? id;

  late String nome;

  late String senha;

  late String email;

  late String telefone;

  late String? cpf;

  late List<TelefoneModel> telefones;

  late List<EmailModel> emails;

  late List<LoteModel> lotes;

  late List<EnderecoModel> enderecos;


  PessoaModel(this.id, this.nome, this.senha, this.cpf, this.telefones, this.emails,
      this.lotes, this.enderecos);

  PessoaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    cpf = json['cpf'];
    telefones = _convertPhoneList(json);
    emails = _convertEmailList(json);
    lotes = _convertLoteList(json);
    enderecos = _convertEnderecoList(json);
  }

  PessoaModel.fromDatabase(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "senha": senha,
        "cpf": cpf,
        "telefones": telefones.map((e) => e.toJson()).toList(),
        "emails": emails.map((e) => e.toJson()).toList(),
        "lotes": lotes.map((e) => e.toJson()).toList(),
        "enderecos": enderecos.map((e) => e.toJson()).toList(),
      };

  Map<String, dynamic> toLocalDataBase() => {
        "nome": nome,
        "email": emails.first.descricao,
        "senha": senha,
      };

  List<LoteModel> _convertLoteList(Map<String, dynamic> json) {
    return List<LoteModel>.from(
        json['lotes'].map((lote) => LoteModel.fromJson(lote)) ?? const []);
  }

  List<EmailModel> _convertEmailList(Map<String, dynamic> json) {
    return List<EmailModel>.from(
        json['emails'].map((email) => EmailModel.fromJson(email)) ?? const []);
  }

  List<TelefoneModel> _convertPhoneList(Map<String, dynamic> json) {
    return List<TelefoneModel>.from(
        json['telefones'].map((telefone) => TelefoneModel.fromJson(telefone)) ??
            const []);
  }

  List<EnderecoModel> _convertEnderecoList(Map<String, dynamic> json) {
    return List<EnderecoModel>.from(
        json['enderecos'].map((endereco) => EnderecoModel.fromJson(endereco)) ??
            const []);
  }
}
