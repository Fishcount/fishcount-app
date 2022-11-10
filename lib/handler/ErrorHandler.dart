import 'package:dio/dio.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/widgets/SnackBarBuilder.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static ErrorModel verifyDioError(DioError error) {
    if (error.response != null && error.response!.statusCode != 500) {
      return ErrorModel.fromJson(error.response!.data);
    }
    return ErrorModel(ErrorMessage.serverError, null, null, null);
  }

  static dynamic getSnackBarError(BuildContext context, String? message) {
    message ??= ErrorMessage.serverError;
    return SnackBarBuilder.error(message, Colors.red[400]).buildError(context);
  }

  static dynamic getAlertDialogError(BuildContext context, String? message){
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ops, algo deu errado."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message.toString()),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButtonWidget(
                  buttonText: "Voltar",
                  buttonColor: Colors.red,
                  textSize: 18,
                  textColor: Colors.white,
                  radioBorder: 10,
                  horizontalPadding: 10,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
