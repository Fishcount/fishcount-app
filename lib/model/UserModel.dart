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
}
