import 'package:fishcount_app/model/TaxaCrescimentoModel.dart';

class EspecieModel {
  late int id;

  late String descricao;

  late double pesoMedio;

  late double tamanhoMedio;

  late int qtdeMediaRacao;

  late int diasIntervalo;

  late TaxaCrescimentoModel taxaCrescimento;

  EspecieModel(
    this.id,
    this.descricao,
    this.pesoMedio,
    this.tamanhoMedio,
    this.qtdeMediaRacao,
    this.diasIntervalo,
    this.taxaCrescimento,
  );
}
