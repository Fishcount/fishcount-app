import 'package:fishcount_app/model/AnaliseModel.dart';

class TanqueModel {
  late int id;

  late String especie;

  late DateTime ultimaAnalise;

  late DateTime proximaAnalise;

  late DateTime dataUltimaAnalise;

  late DateTime dataUltimoTratamento;

  late List<AnaliseModel> analises;
}
