import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/api/ApiEspecie.dart';
import 'package:fishcount_app/model/EspecieModel.dart';
import 'package:fishcount_app/model/TaxaCrescimentoModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';

class TaxaCrescimentoService extends AbstractService {
  String url = ApiEspecie.baseUrl;

  Future<TaxaCrescimentoModel> findByEspecie(String descricao) async {
    try {
      Response<dynamic> response =
          await CustomDio().dioGet(url + "/taxa?especie=$descricao");

      TaxaCrescimentoModel? taxaCrescimento;
      if (response.statusCode == 200) {
        taxaCrescimento = TaxaCrescimentoModel.fromJson(response.data);
      }
      return taxaCrescimento!;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
