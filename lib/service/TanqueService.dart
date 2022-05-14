import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/api/ApiLote.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TanqueSerice extends AbstractService {
  String url = ApiLote.baseUrl + "/{loteId}/tanque";

  Future<List<TanqueModel>> listarTanquesFromLote(LoteModel lote) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');

      Response<List<dynamic>> response = await getAll(url
          .replaceAll("{parentId}", userId.toString())
          .replaceAll("{loteId}", lote.id.toString()));

      if (response.statusCode == 200) {
        List<TanqueModel> tanques = [];
        if (response.data != null) {
          for (var element in response.data!) {
            tanques.add(TanqueModel.fromJson(element));
          }
          return tanques;
        }
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
