import 'package:dio/dio.dart';
import 'package:fishcount_app/model/PlanModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';

class PlanService extends AbstractService {
  static const String url = "/plano";

  Future<List<PlanModel>> listarPlanos() async {
    try {
      Response<List<dynamic>> response =
          await RequestBuilder(url: url).getAll();

      if (response.statusCode == 200) {
        List<PlanModel> planos = [];
        if (response.data != null) {
          for (var element in response.data!) {
            planos.add(PlanModel.fromJson(element));
          }
          return planos;
        }
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
