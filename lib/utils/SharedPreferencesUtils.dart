import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/UsuarioModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> addLocalSharedPreferences(
      int idUsuario, UsuarioModel usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userId", idUsuario);
    prefs.setString("userEmail", usuario.emails.first.descricao);
  }

  static Future<void> addSharedPreferences(AuthUserModel auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", auth.token);
    prefs.setInt("userId", auth.id);
    prefs.setString("userEmail", auth.username);
  }

  static Future<int?> getUserIdFromShared() async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getInt("userId");
  }

  static Future<SharedPreferences> getSharedPreferences() async {
    return SharedPreferences.getInstance();
  }
}
