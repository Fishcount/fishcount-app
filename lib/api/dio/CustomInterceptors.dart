import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomInterceptors extends InterceptorsWrapper {
  static const List<String> notProtectedPaths = [AppPaths.loginPath];

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!notProtectedPaths.contains(options.path)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      options.headers.addAll({"Bearer ": prefs.getString("token")});
    }
    super.onRequest(options, handler);
  }
}
