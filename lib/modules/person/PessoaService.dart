import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

import '../login/LoginService.dart';

class PersonService extends AbstractService {
  LoginService _loginService = LoginService();

  Future<PersonModel> findById() async {
    try {
      final int? id = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<dynamic> response =
          await RequestBuilder(url: '/pessoa/$id').get();

      return PersonModel.fromJson(response.data);
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

      return PersonModel.fromJson(response.data);
    } on DioError catch (e) {
      return customDioError(e);
    }
  }

  Future<dynamic> update(PersonModel person) async {
    try {
      int? personId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      Response<void> response = await RequestBuilder(url: '/pessoa')
          .addQueryParam("cpf", person.cpf.toString())
          .addQueryParam("pessoaId", personId.toString())
          .buildUrl()
          .setBody(person.toJson())
          .put();

      return person;
    } on DioError catch (e) {
      return customDioError(e);
    }
  }
}
