import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../login/LoginService.dart';

class PessoaService extends AbstractService {

  Future<List<PersonModel>> findById() async {
    try {
      final int? id = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<dynamic> response =
          await RequestBuilder(url: '/pessoa/$id').get();

      if (response.statusCode == Responses.OK_STATUS_CODE) {
        return [PersonModel.fromJson(response.data)];
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<dynamic> saveOrUpdate(PersonModel person) async {
    try {
      if (person.id != null) {
        return await update(person);
      }

      Response<dynamic> response =
          await RequestBuilder(url: '/pessoa').setBody(person.toJson()).post();

      if (response.statusCode == 201) {
        LoginService().doLogin(
          person.emails.first.email,
          person.password,
        );
        return PersonModel.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  Future<dynamic> update(PersonModel person) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<void> response = await RequestBuilder(url: '/pessoa/$personId')
          .setBody(person.toJson())
          .put();

      return person;
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
