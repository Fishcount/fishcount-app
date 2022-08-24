class AnalysisModel {
  late int id;

  late double foodAmount;

  late double averageWeight;

  late double averageFoodAmount;

  late DateTime analysisDate;

  AnalysisModel(
    this.id,
    this.foodAmount,
    this.averageWeight,
    this.averageFoodAmount,
    this.analysisDate,
  );

  AnalysisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodAmount = json['qtdeRacao'];
    averageWeight = json['pesoMedio'];
    averageFoodAmount = json['qtdeMediaRacao'];
    analysisDate = json['dataAnalise'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "qtdeRacao": foodAmount,
        "pesoMedio": averageWeight,
        "qtdeMediaRacao": averageFoodAmount,
        "dataAnalise": analysisDate
      };
}
