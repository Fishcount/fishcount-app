import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/api/ApiLote.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotesService {
  String url = ApiLote.baseUrl;

  Future<List<LoteModel>> listarLotesUsuario() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      if (userId == null) {
        return [];
      }
      Response<List<dynamic>> response = await CustomDio()
          .getAll(url.replaceAll("{parentId}", userId.toString()));

      if (response.statusCode == 200) {
        List<LoteModel> lotes = [];
        if (response.data != null) {
          response.data!.forEach((element) {
            lotes.add(LoteModel.fromJson(element));
          });
        }
        return [];
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
