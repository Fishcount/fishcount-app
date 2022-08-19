import 'package:dio/dio.dart';
import 'package:fishcount_app/utils/UrlBuilder.dart';

import '../../../constants/EnumSharedPreferences.dart';
import '../../../model/PixModel.dart';
import '../../../service/generic/AbstractService.dart';
import '../../../utils/SharedPreferencesUtils.dart';

class PixService extends AbstractService {
  Future<PixModel> buscarQRCodePorParcela(int parcelaId) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      final String url = UrlBuilder(baseUrl: '/pessoa')
          .addParam('$pessoaId')
          .addParam('pix')
          .addParam('parcela')
          .addParam('$parcelaId')
          .build();
      Response<dynamic> response = await get(url);

      return PixModel.fromJson(response.data!);
    } on DioError catch (e) {
      rethrow;
    }
  }
}
