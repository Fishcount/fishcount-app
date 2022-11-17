import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/EnumSharedPreferences.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/utils/SharedPreferencesUtils.dart';

class CustomInterceptors extends Interceptor {
  static const List<String> notProtectedPaths = ["/login", "/usuario/cadastro"];

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!notProtectedPaths.contains(options.path)) {
      String? accessToken =
          await SharedPreferencesUtils.getStringVariableFromShared(
              EnumSharedPreferences.accessToken);
      if (accessToken == null) {
        return;
      }
      options.headers["Authorization"] = "Bearer " + accessToken;
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
