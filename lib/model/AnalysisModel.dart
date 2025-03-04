class AnalysisModel {
  late int? id;

  late double? avergageTankWeight;

  late String? foodType;

  late double? dailyFoodAmount;

  late int? fishAmount;

  late String? unityWeitghDailyFood;

  late double? mealFoodAmout;

  late String? unityWeitghMealFood;

  late int? dailyFoodFrequency;

  late dynamic tankTemperature;

  late String analysisStatus;

  late String analysisDate;

  AnalysisModel(
    this.avergageTankWeight,
    this.foodType,
    this.fishAmount,
    this.dailyFoodAmount,
    this.unityWeitghDailyFood,
    this.mealFoodAmout,
    this.unityWeitghMealFood,
    this.dailyFoodFrequency,
    this.tankTemperature,
    this.analysisStatus,
    this.analysisDate,
  );

  AnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avergageTankWeight = json['pesoMedioTanque'];
    foodType = json['tipoRacao'];
    fishAmount = json['qtdePeixe'];
    dailyFoodAmount = json['qtdeRacaoDiaria'];
    unityWeitghDailyFood = json['unidadePesoRacaoDiaria'];
    mealFoodAmout = json['qtdeRacaoRefeicao'];
    unityWeitghMealFood = json['unidadePesoRacaoRefeicao'];
    dailyFoodFrequency = json['frequenciaAlimentacaoDiaria'];
    tankTemperature = json['temperaturaAgua'] ?? 0;
    analysisStatus = json['statusAnalise'];
    analysisDate = json['dataAnalise'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pesoMedioTanque': avergageTankWeight,
        'tipoRacao': foodType,
        'qtdePeixe': fishAmount,
        'qtdeRacaoDiaria': dailyFoodAmount,
        'unidadePesoRacaoDiaria': unityWeitghDailyFood,
        'qtdeRacaoRefeicao': mealFoodAmout,
        'unidadePesoRacaoRefeicao': unityWeitghMealFood,
        'frequenciaAlimentacaoDiaria': dailyFoodFrequency,
        'temperaturaAgua': tankTemperature,
        'statusAnalise': analysisStatus,
        'dataAnalise': analysisDate,
      };
}
