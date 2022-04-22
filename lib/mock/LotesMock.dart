import 'package:fishcount_app/model/LoteModel.dart';

class LotesMock {
  Future<List<LoteModel>> getLoteModel() async {
    return [
      LoteModel(
        1,
        "Aquele Lote numero 1",
      ),
      LoteModel(
        1,
        "Aquele Lote numero 2",
      ),
      LoteModel(
        1,
        "Aquele Lote numero 1",
      ),
    ];
  }
}
