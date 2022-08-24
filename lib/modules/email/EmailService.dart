import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/api/ApiEmail.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';

class EmailService extends AbstractService {
  dynamic save(EmailModel email, int personId) async {
    try {
      Response<dynamic> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('/email')
          .buildUrl()
          .setBody(email.toJson())
          .post();

      return EmailModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic update(EmailModel email, int personId) async {
    try {
      int? emailId = email.id;

      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('email')
          .addPathParam('$emailId')
          .buildUrl()
          .setBody(email.toJson())
          .put();
      if (response.statusCode == 200) {
        return email;
      }
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic deleteEmail(int emailId, int userId) async {
    try {
      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$userId')
          .addPathParam('email')
          .addPathParam('$emailId')
          .buildUrl()
          .delete();

      if (response.statusCode == 204) {
        return emailId;
      }
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
