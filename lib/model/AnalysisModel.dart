class AnalysisModel {
  late int? id;

  late double? avergageTankWeight;

  late String foodType;

  late double? dailyFoodAmount;

  late String? unityWeitghDailyFood;

  late double? mealFoodAmout;

  late String? unityWeitghMealFood;

  late int? dailyFoodFrequency;

  late String analysisStatus;

  late String analysisDate;

  AnalysisModel(
    this.avergageTankWeight,
    this.foodType,
    this.dailyFoodAmount,
    this.unityWeitghDailyFood,
    this.mealFoodAmout,
    this.unityWeitghMealFood,
    this.dailyFoodFrequency,
    this.analysisStatus,
    this.analysisDate,
  );

  AnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avergageTankWeight = json['pesoMedioTanque'];
    foodType = json['tipoRacao'];
    dailyFoodAmount = json['qtdeRacaoDiaria'];
    unityWeitghDailyFood = json['unidadePesoRacaoDiaria'];
    mealFoodAmout = json['qtdeRacaoRefeicao'];
    unityWeitghMealFood = json['unidadePesoRacaoRefeicao'];
    dailyFoodFrequency = json['frequenciaAlimentacaoDiaria'];
    analysisStatus = json['statusAnalise'];
    analysisDate = json['dataAnalise'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pesoMedioTanque': avergageTankWeight,
        'tipoRacao': foodType,
        'qtdeRacaoDiaria': dailyFoodAmount,
        'unidadePesoRacaoDiaria': unityWeitghDailyFood,
        'qtdeRacaoRefeicao': mealFoodAmout,
        'unidadePesoRacaoRefeicao': unityWeitghMealFood,
        'frequenciaAlimentacaoDiaria': dailyFoodFrequency,
        'statusAnalise': analysisStatus,
        'dataAnalise': analysisDate,
      };
}
