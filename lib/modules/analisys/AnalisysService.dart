import 'package:dio/dio.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AnalysisModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';

class AnalisysService extends AbstractService {
  Future<List<AnalysisModel>> fetchAnalisys(int tankId, String? status) async {
    try {
      RequestBuilder requestBuilder = RequestBuilder(url: '/analise')
          .addQueryParam('tanqueId', tankId.toString());

      if (status != null) {
        requestBuilder.addQueryParam('statusAnalise', status);
      }

      Response<List<dynamic>> response =
          await requestBuilder.buildUrl().getAll();
      if (response.statusCode == 200) {
        List<AnalysisModel> analisys = [];
        if (response.data != null) {
          for (var element in response.data!) {
            analisys.add(AnalysisModel.fromJson(element));
          }
          return analisys;
        }
      }
      return [];
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic initiateAnalisys(int tankId) async {
    try {
      Response<dynamic> response = await RequestBuilder(url: '/analise')
          .addQueryParam('tanqueId', tankId.toString())
          .hasBody(false)
          .buildUrl()
          .post();

      if (response.statusCode == 201) {
        return AnalysisModel.fromJson(response.data);
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
