import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/ApiUsuario.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:fishcount_app/service/LoginService.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PessoaService extends AbstractService {
  String url = ApiPessoa.baseUrl;

  // @todo corrigir retorno para dynamic
  Future<List<PessoaModel>> buscarPessoa() async {
    try {
      final int? id = await SharedPreferencesUtils.getIntVariableFromShared(EnumSharedPreferences.userId);

      String managedUrl = url + "/$id";
      Response<dynamic> response = await CustomDio().dioGet(managedUrl);
      if (response.statusCode == Responses.OK_STATUS_CODE) {
        return [PessoaModel.fromJson(response.data)];
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<dynamic> salvarOuAtualizar(PessoaModel pessoa) async {
    try {
      if (pessoa.id != null) {
        int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(EnumSharedPreferences.userId);

        await put(url + "/$pessoaId", pessoa.toJson());
        return pessoa;
      }

      Response<dynamic> response =
          await post(url, pessoa.toJson());
      if (response.statusCode == Responses.CREATED_STATUS_CODE) {
        LoginService().doLogin(
          pessoa.emails.first.descricao,
          pessoa.senha,
        );
        return PessoaModel.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }
}
