import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';

import '../../handler/ErrorHandler.dart';

abstract class AbstractService extends CustomDio {

  dynamic customDioError(DioError e){
    return ErrorHandler.verifyDioError(e);
  }
}
