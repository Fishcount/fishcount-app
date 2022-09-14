import 'package:dio/dio.dart';
import 'package:fishcount_app/api/dio/CustomDio.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';

import '../../handler/ErrorHandler.dart';

abstract class AbstractService extends CustomDio {

  dynamic customDioError(DioError e){
    final ErrorModel error =  ErrorHandler.verifyDioError(e);
    if (error.details != null && error.details!.isNotEmpty) {
      if (error.message != null) {
        error.message = error.message! + ' ' + error.details!.first;
      }
    }
    return error;
  }
}
