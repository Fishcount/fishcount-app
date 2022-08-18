import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/api/ApiPagamento.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import '../../../constants/EnumSharedPreferences.dart';
import '../../../model/PagamentoParcelaModel.dart';

class PagamentoParcelaService extends AbstractService {
  static String url = ApiPagamento.baseUrl + '/{pagamentoId}/parcela';

  Future<List<PagamentoParcelaModel>> buscarPagamentosParcela(
      int pagamentoId) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      url = url
          .replaceAll("{parentId}", pessoaId.toString())
          .replaceAll("{pagamentoId}", pagamentoId.toString());

      Response<List<dynamic>> response = await getAll(url);
      if (response.statusCode == 200) {
        List<PagamentoParcelaModel> parcelas = [];
        if (response.data != null) {
          if (response.data!.isEmpty) {
            return [];
          }
          for (var lote in response.data!) {
            parcelas.add(PagamentoParcelaModel.fromJson(lote));
          }
        }
        return parcelas;
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
