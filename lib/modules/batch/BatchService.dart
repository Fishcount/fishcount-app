import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

class BatchService extends AbstractService {


  Future<List<BatchModel>> fetchBatches() async {
    try {
      final int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      final Response<List<dynamic>> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$pessoaId')
          .addPathParam('lote')
          .buildUrl()
          .getAll();

      if (response.statusCode == 200) {
        List<BatchModel> batches = [];
        if (response.data != null) {
          if (response.data!.isEmpty) {
            return [];
          }
          for (var batch in response.data!) {
            batches.add(BatchModel.fromJson(batch));
          }
        }
        return batches;
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  dynamic saveOrUpdate(BatchModel batch) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      RequestBuilder requestOptions = RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('lote')
          .buildUrl()
          .setBody(batch.toJson());

      if (batch.id != null) {
        await requestOptions.put();
        return batch;
      }
      Response<dynamic> response = await requestOptions.post();
      if (response.statusCode == 201) {
        return BatchModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }


}
