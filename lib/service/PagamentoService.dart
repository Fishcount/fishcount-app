import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/api/ApiUsuario.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

class PagamentoService extends AbstractService {
  static String url = ApiPessoa.baseUrl + "/{pessoaId}/pagamento";

  Future<dynamic> incluirAssinaturaPlano(PagamentoModel pagamentoModel) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);
      url = url.replaceAll("{pessoaId}", pessoaId.toString());

      Response<dynamic> response = await post(url, pagamentoModel.toJson());
      if (response.statusCode == 201) {
        PagamentoModel pagamentoResponse =
            PagamentoModel.fromJson(response.data);
        return pagamentoResponse;
      }
      return ErrorModel.fromJson(response.data);
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }

  Future<List<PagamentoModel>> buscarPagamentos() async {
    try {
      final int? id = await SharedPreferencesUtils.getIntVariableFromShared(EnumSharedPreferences.userId);

      String managedUrl = url + "/$id/pagamento";
      Response<List<dynamic>> response = await getAll(managedUrl);

      if (response.statusCode == 200) {
          List<PagamentoModel> pagamentos = [];
          if (response.data != null) {
            if (response.data!.isEmpty) {
              return [];
            }
            for (var lote in response.data!) {
              pagamentos.add(PagamentoModel.fromJson(lote));
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
