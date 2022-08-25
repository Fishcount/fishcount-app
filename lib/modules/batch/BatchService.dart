import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

class BatchService extends AbstractService {
  Future<List<BatchModel>> fetchBatches() async {
    try {
      final int? pessoaId =
          await SharedPreferencesUtils.getIntVariableFromShared(
              EnumSharedPreferences.userId);

      final Response<List<dynamic>> response =
          await RequestBuilder(url: '/pessoa')
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

  dynamic update(BatchModel batch) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      int batchId = batch.id!;

       await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('lote')
          .addPathParam('$batchId')
          .buildUrl()
          .setBody(batch.toJson())
          .put();

      return batch;
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic save(BatchModel batch) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<dynamic> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('lote')
          .buildUrl()
          .setBody(batch.toJson())
          .post();

      return BatchModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic deleteBath(int batchId) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('lote')
          .addPathParam('$batchId')
          .buildUrl()
          .delete();

      if (response.statusCode == 204) {
        return batchId;
      }
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
