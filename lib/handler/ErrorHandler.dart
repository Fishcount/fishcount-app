import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/widgets/SnackBarBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static ErrorModel verifyDioError(DioError error) {
    if (error.response != null && error.response!.statusCode != 500) {
      return ErrorModel.fromJson(error.response!.data);
    }
    return ErrorModel(ErrorMessage.serverError, null, null, null);
  }

  static dynamic getDefaultErrorMessage(BuildContext context, String? message) {
    message ??= ErrorMessage.serverError;
    return SnackBarBuilder.error(message, Colors.red[400]).buildError(context);
  }
}
