

import 'LocationPixModel.dart';

class PixModel {
  late int? id;

  late String qrCode;

  late LocationPixModel locationPix;

  PixModel(
    this.id,
    this.qrCode,
    this.locationPix,
  );

  PixModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qrCode = json['qrCode'];
    locationPix = LocationPixModel.fromJson(json['locationPix']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "qrCode": qrCode,
        "locationPix": locationPix,
      };
}
