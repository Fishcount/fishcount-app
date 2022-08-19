class LocationPixModel {
  late int? id;

  late int idLocation;

  late String location;

  late String tipoCob;

  late String dataCriacao;

  LocationPixModel(
    this.id,
    this.idLocation,
    this.location,
    this.tipoCob,
    this.dataCriacao,
  );

  LocationPixModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idLocation = json['idLocation'];
    location = json['location'];
    tipoCob = json['tipoCob'];
    dataCriacao = json['dataCriacao'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLocation": idLocation,
        "location": location,
        "tipoCob": tipoCob,
        "dataCriacao": dataCriacao
      };
}
