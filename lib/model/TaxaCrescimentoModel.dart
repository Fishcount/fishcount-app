import 'package:fishcount_app/model/enums/EnumUnidadeAumento.dart';
import 'package:fishcount_app/model/enums/EnumUnidadeIntervalo.dart';

class TaxaCrescimentoModel {
  late int? id;

  late double? qtdeAumento;

  late int? intervalo;

  late EnumUnidadeAumento unidadeAumento;

  late EnumUnidadeIntervalo unidadeIntervalo;

  TaxaCrescimentoModel(
    this.id,
    this.qtdeAumento,
    this.intervalo,
    this.unidadeAumento,
    this.unidadeIntervalo,
  );

  TaxaCrescimentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qtdeAumento = json['qtdeAumento'];
    unidadeAumento = UnidadeAumentoHandler.handle(json['unidadeAumento']);
    intervalo = json['intervalo'];
    unidadeIntervalo = UnidadeIntervaloHandler.handle(json['unidadeIntervalo']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "qtdeAumento": qtdeAumento,
        "intervalo": intervalo,
        "unidadeAumento": unidadeAumento.name,
        "unidadeIntervalo": unidadeIntervalo.name,
      };
}
