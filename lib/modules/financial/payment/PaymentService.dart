import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/api/ApiUsuario.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PaymentModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

class PagamentoService extends AbstractService {
  static String url = ApiPessoa.baseUrl + "/{pessoaId}/pagamento";

  Future<dynamic> incluirAssinaturaPlano(PaymentModel pagamentoModel) async {
    try {
      final int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      final Response<dynamic> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$pessoaId')
          .addPathParam('/pagamento')
          .buildUrl()
          .setBody(pagamentoModel.toJson())
          .post();

      if (response.statusCode == 201) {
        PaymentModel pagamentoResponse =
            PaymentModel.fromJson(response.data);
        return pagamentoResponse;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }

  Future<List<PaymentModel>> buscarPagamentos() async {
    try {
      final int? pessoaId =
          await SharedPreferencesUtils.getIntVariableFromShared(
              EnumSharedPreferences.userId);

      final Response<List<dynamic>> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$pessoaId')
          .addPathParam('/pagamento')
          .buildUrl()
          .getAll();

      if (response.statusCode == 200) {
        List<PaymentModel> pagamentos = [];
        if (response.data != null) {
          if (response.data!.isEmpty) {
            return [];
          }
          for (var lote in response.data!) {
            pagamentos.add(PaymentModel.fromJson(lote));
          }
        }
        return pagamentos;
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }
}
