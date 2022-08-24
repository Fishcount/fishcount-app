import 'package:dio/dio.dart';
import 'package:fishcount_app/utils/RequestBuilder.dart';

import '../../../constants/EnumSharedPreferences.dart';
import '../../../model/PixModel.dart';
import '../../../service/generic/AbstractService.dart';
import '../../../utils/SharedPreferencesUtils.dart';

class PixService extends AbstractService {
  Future<PixModel> buscarQRCodePorParcela(int parcelaId) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      final Response<dynamic> response =
          await RequestBuilder(url: '/pessoa/$pessoaId/pix/parcela/$parcelaId')
              .get();

      return PixModel.fromJson(response.data!);
    } on DioError catch (e) {
      rethrow;
    }
  }
}
