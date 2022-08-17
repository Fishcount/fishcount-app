import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/ApiLote.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/model/TanqueModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../exceptionHandler/ErrorModel.dart';

class TanqueService extends AbstractService {
  String url = ApiLote.baseUrl + "/{loteId}/tanque";

  Future<List<TanqueModel>> listarTanquesFromLote(LoteModel lote) async {
    try {
      int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

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

  dynamic saveOrUpdateTank(TanqueModel tanque, LoteModel lote) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      url = url
          .replaceAll("{parentId}", pessoaId.toString())
          .replaceAll("{loteId}", lote.id.toString());
      if (tanque.id != null) {
        await put(url, tanque.toJson());
        return tanque;
      }

      final Response<dynamic> response = await post(url, tanque.toJson());
      if (response.statusCode == Responses.CREATED_STATUS_CODE) {
        return TanqueModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      rethrow;
    }
  }
}
