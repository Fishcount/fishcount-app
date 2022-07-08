import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/PessoaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> addLocalSharedPreferences(
      int idUsuario, PessoaModel usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(EnumSharedPreferences.userId.name, idUsuario);
    prefs.setString(
        EnumSharedPreferences.userEmail.name, usuario.emails.first.descricao);
  }

  static Future<void> addSharedPreferences(AuthUserModel auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumSharedPreferences.accessToken.name, auth.token);
    prefs.setInt(EnumSharedPreferences.userId.name, auth.pessoaId);
    prefs.setString(EnumSharedPreferences.userEmail.name, auth.username);
  }

  static Future<int?> getIntVariableFromShared(
      EnumSharedPreferences shared) async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getInt(shared.name);
  }

  static Future<String?> getStringVariableFromShared(
      EnumSharedPreferences shared) async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getString(shared.name);
  }

  static Future<SharedPreferences> getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }
}
