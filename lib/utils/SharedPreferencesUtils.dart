import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/model/AuthUserModel.dart';
import 'package:fishcount_app/model/PersonModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<void> addLocalSharedPreferences(
      int personId, PersonModel person) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(EnumSharedPreferences.userId.name, personId);
    prefs.setString(
        EnumSharedPreferences.userEmail.name, person.emails.first.email);
  }

  static Future<SharedPreferences> addSharedPreferences(AuthUserModel auth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EnumSharedPreferences.accessToken.name, auth.token);
    prefs.setInt(EnumSharedPreferences.userId.name, auth.personId);
    prefs.setString(EnumSharedPreferences.userEmail.name, auth.username);
    return prefs;
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
