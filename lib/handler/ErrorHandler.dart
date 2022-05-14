import 'package:fishcount_app/constants/exceptions/ExceptionsMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:dio/dio.dart';
import 'package:fishcount_app/widgets/custom/CustomSnackBar.dart';
import 'package:flutter/cupertino.dart';


class ErrorHandler{

  static ErrorModel verifyDioError(DioError error) {
    if (error.response != null) {
      return ErrorModel.fromJson(error.response!.data);
    }
    return ErrorModel(ExceptionsMessage.serverError, null, null, null);
  }

  static Widget getDefaultErrorMessage(BuildContext context, dynamic response) {
    return CustomSnackBar.getCustomSnackBar(context, response);
  }
}