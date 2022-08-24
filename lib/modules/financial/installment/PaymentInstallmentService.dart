import 'package:dio/dio.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../../../constants/EnumSharedPreferences.dart';
import '../../../model/PagamentoParcelaModel.dart';

class PaymentInstallmentService extends AbstractService {

  Future<List<PagamentoParcelaModel>> buscarPagamentosParcela(
      int pagamentoId) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<List<dynamic>> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$pessoaId')
          .addPathParam('pagamento')
          .addPathParam('$pagamentoId')
          .addPathParam('/parcela')
          .buildUrl()
          .getAll();

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
