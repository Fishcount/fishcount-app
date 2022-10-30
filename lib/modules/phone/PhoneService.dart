import 'package:dio/dio.dart';
import 'package:fishcount_app/model/PhoneModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';

class PhoneService extends AbstractService {
  dynamic save(PhoneModel phoneModel, int personId) async {
    try {
      Response<dynamic> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('telefone')
          .buildUrl()
          .setBody(phoneModel.toJson())
          .post();

      return PhoneModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic update(PhoneModel phone, int personId) async {
    try {
      int? phoneId = phone.id;

      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$personId')
          .addPathParam('telefone')
          .addPathParam('$phoneId')
          .buildUrl()
          .setBody(phone.toJson())
          .put();
      if (response.statusCode == 200) {
        return phone;
      }
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  dynamic delete(int phoneId, int userId) async {
    try {
      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addPathParam('$userId')
          .addPathParam('telefone')
          .addPathParam('$phoneId')
          .buildUrl()
          .delete();

      if (response.statusCode == 204) {
        return phoneId;
      }
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
