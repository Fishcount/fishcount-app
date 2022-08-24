class AddressModel {
  late int? id;

  AddressModel(this.id);

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
