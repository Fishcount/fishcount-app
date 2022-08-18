import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/api/ApiEspecie.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:flutter/cupertino.dart';

class EspecieService extends AbstractService {
  String url = ApiEspecie.baseUrl;

  Future<EspecieModel> findByDescricao(String descricao) async {
    try {
      Response<dynamic> response = await CustomDio().dioGet(url + "/find?descricao=$descricao");

      EspecieModel? especieModel;
      if (response.statusCode == 200){
        especieModel = EspecieModel.fromJson(response.data);
      }
      return especieModel!;
    } on DioError catch (e){
      rethrow;
    }
  }

  Future<EspecieModel> findFirst() async {
    try {
      Response<dynamic> response = await CustomDio().dioGet(url + "/first");

      EspecieModel? especieModel;
      if (response.statusCode == 200){
        especieModel = EspecieModel.fromJson(response.data);
      }
      return especieModel!;
    } on DioError catch (e){
      rethrow;
    }
  }

  Future<List<EspecieModel>> listarEspecies(BuildContext context) async {
    try {
      Response<List<dynamic>> response = await getAll(url);

      if (response.statusCode == 200) {
        List<EspecieModel> especies = [];
        if (response.data != null) {
          for (var element in response.data!) {
            especies.add(EspecieModel.fromJson(element));
          }
          return especies;
        }
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
