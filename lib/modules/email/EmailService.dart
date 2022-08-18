import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/api/ApiEmail.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';

class EmailService extends AbstractService {
  String url = ApiEmail.baseUrl;

  // @toDo Adicionar if de statusCode do retorno da API
  dynamic salvarEmail(EmailModel email, int userId) async {
    try {
      url = url.replaceAll("{parentId}", userId.toString());

      Response<dynamic> response = await post(url, email.toJson());

      return EmailModel.fromJson(response.data);
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }

  dynamic atualizarEmail(EmailModel email, int userId) async {
    try {
      int? emailId = email.id;
      url = url.replaceAll("{parentId}", userId.toString()) + "/$emailId";

      Response<void> response = await put(url, email.toJson());
      if (response.statusCode == 200) {
        return email;
      }
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }

  dynamic excluirEmail(int emailId, int userId) async {
    try {
      url = url.replaceAll("{parentId}", userId.toString()) + "/$emailId";

      Response<void> response = await delete(url);
      if (response.statusCode == 204){
        return emailId;
      }

    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }
}
