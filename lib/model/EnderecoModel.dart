class EnderecoModel {
  late int? id;

  EnderecoModel(this.id);

  EnderecoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
