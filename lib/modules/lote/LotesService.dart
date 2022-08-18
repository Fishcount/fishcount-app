import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
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
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(EnumSharedPreferences.userId);
      if (pessoaId == null) {
        return [];
      }
      url = url.replaceAll("{parentId}", pessoaId.toString());

      Response<List<dynamic>> response = await getAll(url);

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
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(EnumSharedPreferences.userId);
      if (pessoaId == null) {
        return [];
      }
      url = url.replaceAll("{parentId}", pessoaId.toString());

      if (url.isEmpty) {
        return;
      }
      if (lote.id != null) {
        await put(url, lote.toJson());
        return lote;
      }
      Response<dynamic> response = await post(url, lote.toJson());
      if (response.statusCode == Responses.CREATED_STATUS_CODE) {
        return LoteModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }
}
