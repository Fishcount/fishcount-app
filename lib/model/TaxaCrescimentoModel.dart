import 'package:fishcount_app/model/enums/EnumUnidadeAumento.dart';
import 'package:fishcount_app/model/enums/EnumUnidadeIntervalo.dart';

class TaxaCrescimentoModel {
  late int id;

  late int periodoAnalise;

  late double qtdeAumento;

  late int intervalo;

  late EnumUnidadeAumento unidadeAumento;

  late EnumUnidadeIntervalo unidadeIntervalo;

  TaxaCrescimentoModel(
    this.id,
    this.periodoAnalise,
    this.qtdeAumento,
    this.intervalo,
    this.unidadeAumento,
    this.unidadeIntervalo,
  );

  TaxaCrescimentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    periodoAnalise = json['periodoAnalise'];
    qtdeAumento = json['qtdeAumento'];
    intervalo = json['intervalo'];
    unidadeAumento = json['unidadeAumento'];
    unidadeIntervalo = json['unidadeIntervalo'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "periodoAnalise": periodoAnalise,
        "qtdeAumento": qtdeAumento,
        "intervalo": intervalo,
        "unidadeAumento": unidadeAumento,
        "unidadeIntervalo": unidadeIntervalo,
      };
}
