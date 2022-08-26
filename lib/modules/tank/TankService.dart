import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/api/ApiLote.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../../exceptionHandler/ErrorModel.dart';

class TankService extends AbstractService {
  String url = ApiLote.baseUrl + "/{loteId}/tanque";

  Future<List<TankModel>> fetchTanks(
      {batch = TankModel, orderBy = String}) async {
    try {
      final int? userId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      final int? batchId = batch.id;

      RequestBuilder requestBuilder = RequestBuilder(url: '/pessoa')
          .addPathParam('$userId')
          .addPathParam('lote')
          .addPathParam('$batchId')
          .addPathParam('tanque');

      Response<List<dynamic>> response;
      if (orderBy != null) {
        response = await requestBuilder
            .addQueryParam('orderBy', orderBy)
            .buildUrl()
            .getAll();
      } else {
        response = await requestBuilder.buildUrl().getAll();
      }

      if (response.statusCode == 200) {
        List<TankModel> tanques = [];
        if (response.data != null) {
          for (var element in response.data!) {
            tanques.add(TankModel.fromJson(element));
          }
          return tanques;
        }
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  dynamic saveOrUpdateTank(TankModel tank, BatchModel batch) async {
    try {
      final int? personId =
          await SharedPreferencesUtils.getIntVariableFromShared(
              EnumSharedPreferences.userId);
      final int? batchId = batch.id;

      RequestBuilder requestBuilder = RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('lote')
          .addPathParam('$batchId')
          .addPathParam('tanque');

      if (tank.id != null) {
        final int tanqueId = tank.id!;
        await requestBuilder
            .addPathParam('$tanqueId')
            .buildUrl()
            .setBody(tank.toJson())
            .put();
        return tank;
      }

      final Response<dynamic> response =
          await requestBuilder.buildUrl().setBody(tank.toJson()).post();

      if (response.statusCode == 201) {
        return TankModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      rethrow;
    }
  }
}
