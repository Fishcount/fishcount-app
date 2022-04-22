import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomInterceptors extends Interceptor {
  static const List<String> notProtectedPaths = [AppPaths.loginPath];

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!notProtectedPaths.contains(options.path)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      options.headers["Authorization"] = "Bearer " + prefs.getString("token")!;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      print(err.message);
    }
    super.onError(err, handler);
  }
}
