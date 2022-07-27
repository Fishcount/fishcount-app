import 'package:fishcount_app/constants/api/Environment.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:dio/dio.dart';


class PlanoService extends AbstractService {

  static const String url = Environment.urlServer + "/plano";


  Future<List<PlanoModel>> listarPlanos() async {
    try {
      Response<List<dynamic>> response = await getAll(url);

      if (response.statusCode == 200) {
        List<PlanoModel> planos = [];
        if (response.data != null) {
          for (var element in response.data!) {
            planos.add(PlanoModel.fromJson(element));
          }
          return planos;
        }
      }
      return [];
    } on DioError catch (e){
      rethrow;
    }
  }

}