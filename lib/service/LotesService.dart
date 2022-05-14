import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/ApiLote.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LotesService extends AbstractService {
  String url = ApiLote.baseUrl;

  Future<List<LoteModel>> listarLotesUsuario() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String managedUrl = _getManagedUrl(prefs);
      if (managedUrl.isEmpty) {
        return [];
      }
      Response<List<dynamic>> response = await getAll(managedUrl);

      if (response.statusCode == 200) {
        List<LoteModel> lotes = [];
        if (response.data != null) {
          if (response.data!.isEmpty) {
            return [];
          }
          for (var lote in response.data!) {
            lotes.add(LoteModel.fromJson(lote));
          }
        }
        return lotes;
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  dynamic salvarOrAtualizarLote(LoteModel lote) async {
    try {
      SharedPreferences prefs = await SharedPreferencesUtils.getSharedPreferences();
      String managedUrl = _getManagedUrl(prefs);
      if (managedUrl.isEmpty) {
        return;
      }
      if (lote.id != null) {
        await put(managedUrl, lote.toJson());
        return lote;
      }
      Response<dynamic> response = await post(managedUrl, lote.toJson());
      if (response.statusCode == Responses.CREATED_STATUS_CODE) {
        return LoteModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }

  String _getManagedUrl(SharedPreferences prefs) {
    int? userId = prefs.getInt('userId');
    if (userId == null) {
      return "";
    }
    return url.replaceAll("{parentId}", userId.toString());
  }
}
