import 'package:dio/dio.dart';
import 'package:fishcount_app/model/SpeciesModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:flutter/cupertino.dart';

class SpeciesService extends AbstractService {

  Future<SpeciesModel> findByDescricao(String descricao) async {
    try {
      Response<dynamic> response = await RequestBuilder(url: '/especie')
          .addPathParam('find')
          .addQueryParam('descricao', descricao)
          .buildUrl()
          .get();

      return SpeciesModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  Future<SpeciesModel> findFirst() async {
    try {
      Response<dynamic> response =
          await RequestBuilder(url: '/especie/first').get();

      return SpeciesModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  Future<List<SpeciesModel>> listarEspecies(BuildContext context) async {
    try {
      Response<List<dynamic>> response =
          await RequestBuilder(url: '/especie').getAll();

      if (response.statusCode == 200) {
        List<SpeciesModel> especies = [];
        if (response.data != null) {
          for (var element in response.data!) {
            especies.add(SpeciesModel.fromJson(element));
          }
          return especies;
        }
      }
      return [];
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
