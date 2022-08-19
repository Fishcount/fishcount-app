import 'package:fishcount_app/constants/api/ApiUsuario.dart';
import 'package:dio/dio.dart';
import '../../../constants/EnumSharedPreferences.dart';
import '../../../model/PixModel.dart';
import '../../../service/generic/AbstractService.dart';
import '../../../utils/SharedPreferencesUtils.dart';

class PixService extends AbstractService {
  static String url = ApiPessoa.baseUrl + '/{parentId}/pix';

   Future<List<PixModel>> buscarQRCodePorParcela(int parcelaId) async {
    try {
      int? pessoaId = await SharedPreferencesUtils.getIntVariableFromShared(
          EnumSharedPreferences.userId);

      url = url
          .replaceAll("{parentId}", pessoaId.toString())
          + '/parcela/$parcelaId';
      Response<List<dynamic>> response = await getAll(url);
      if (response.statusCode == 200) {
        List<PixModel> pixModel = [];
        if (response.data != null) {
          if (response.data!.isEmpty) {
            return [];
          }
          for (var lote in response.data!) {
            pixModel.add(PixModel.fromJson(lote));
          }
        }
        return pixModel;
      }
      return [];

    } on DioError catch (e) {
      rethrow;
    }
  }
}
