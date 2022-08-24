import 'package:fishcount_app/model/enums/EnumUnidadeAumento.dart';
import 'package:fishcount_app/model/enums/EnumUnidadeIntervalo.dart';

class GrowthRateModel {
  late int? id;

  late double? increaseAmount;

  late int? interval;

  late EnumUnidadeAumento increaseUnit;

  late EnumUnidadeIntervalo intervalUnity;

  GrowthRateModel(
    this.id,
    this.increaseAmount,
    this.interval,
    this.increaseUnit,
    this.intervalUnity,
  );

  GrowthRateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    increaseAmount = json['qtdeAumento'];
    increaseUnit = UnidadeAumentoHandler.handle(json['unidadeAumento']);
    interval = json['intervalo'];
    intervalUnity = UnidadeIntervaloHandler.handle(json['unidadeIntervalo']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "qtdeAumento": increaseAmount,
        "intervalo": interval,
        "unidadeAumento": increaseUnit.name,
        "unidadeIntervalo": intervalUnity.name,
      };
}
