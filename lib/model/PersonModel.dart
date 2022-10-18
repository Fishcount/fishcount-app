import 'package:fishcount_app/model/AddressModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/model/PhoneModel.dart';

class PersonModel {
  late int? id;

  late String name;

  late String password;

  late String email;

  late String? cpf;

  late List<PhoneModel> phones;

  late List<EmailModel> emails;

  late List<BatchModel> batches;

  late List<AddressModel> adresses;

  PersonModel(
    this.id,
    this.name,
    this.password,
    this.cpf,
    this.phones,
    this.emails,
    this.batches,
    this.adresses,
  );

  PersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['nome'] ?? '';
    password = json['senha'] ?? '';
    cpf = json['cpf'] ?? "";
    phones = _convertPhoneList(json);
    emails = _convertEmailList(json);
    batches = _convertBatchesList(json);
    adresses = _convertAdressesList(json);
  }

  PersonModel.fromDatabase(Map<String, dynamic> map) {
    id = map['id'];
    name = map['nome'];
    email = map['email'];
    password = map['senha'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": name,
        "senha": password,
        "cpf": cpf,
        "telefones": phones.map((e) => e.toJson()).toList(),
        "emails": emails.map((e) => e.toJson()).toList(),
        "lotes": batches.map((e) => e.toJson()).toList(),
        "enderecos": adresses.map((e) => e.toJson()).toList(),
      };

  Map<String, dynamic> toLocalDataBase() => {
        "nome": name,
        "email": emails.first.email,
        "senha": password,
      };

  List<BatchModel> _convertBatchesList(Map<String, dynamic> json) {
    return List<BatchModel>.from(
        json['lotes'].map((lote) => BatchModel.fromJson(lote)) ?? const []);
  }

  List<EmailModel> _convertEmailList(Map<String, dynamic> json) {
    return List<EmailModel>.from(
        json['emails'].map((email) => EmailModel.fromJson(email)) ?? const []);
  }

  List<PhoneModel> _convertPhoneList(Map<String, dynamic> json) {
    return List<PhoneModel>.from(
        json['telefones'].map((telefone) => PhoneModel.fromJson(telefone)) ??
            const []);
  }

  List<AddressModel> _convertAdressesList(Map<String, dynamic> json) {
    return List<AddressModel>.from(
        json['enderecos'].map((endereco) => AddressModel.fromJson(endereco)) ??
            const []);
  }
}
