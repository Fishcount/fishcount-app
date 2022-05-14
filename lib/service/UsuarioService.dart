import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/Responses.dart';
import 'package:fishcount_app/constants/api/ApiUsuario.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:fishcount_app/service/generic/AbstractService.dart';
import 'package:fishcount_app/service/LoginService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioService extends AbstractService {
  String url = ApiUsuario.baseUrl;

  Future<List<UsuarioModel>> buscarUsuario() async {
    try {
      String managedUrl = url + "/{id}";
      SharedPreferences prefs = await SharedPreferences.getInstance();

      int id = prefs.getInt("userId")!;

      managedUrl = managedUrl.replaceAll("{id}", id.toString());

      Response<dynamic> response = await getAll(managedUrl);
      if (response.statusCode == Responses.OK_STATUS_CODE) {
        return [UsuarioModel.fromJson(response.data)];
      }
      return [];
    } on DioError catch (e) {
      rethrow;
    }
  }

  dynamic salvarOuAtualizarUsuario(UsuarioModel usuarioModel) async {
    try {
      if (usuarioModel.id != null) {
        await put(url, usuarioModel.toJson());
        return usuarioModel;
      }

      Response<dynamic> response =
          await post(url + "/cadastro", usuarioModel.toJson());
      if (response.statusCode == Responses.CREATED_STATUS_CODE) {
        LoginService().doLogin(
          usuarioModel.emails.first.descricao,
          usuarioModel.senha,
        );
        return UsuarioModel.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      return ErrorHandler.verifyDioError(e);
    }
  }
}
