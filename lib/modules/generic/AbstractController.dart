import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exceptionHandler/ErrorModel.dart';

abstract class AbstractController {
  Container getCircularProgressIndicator() {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
          semanticsLabel: "Carregando",
        ),
      ),
    );
  }

  dynamic _responseIsErrorModel(BuildContext context, dynamic response) {
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
    return true;
  }

  dynamic validateResponse({
    context = BuildContext,
    response = dynamic,
    redirect = Widget,
  }) {
    dynamic validationResult = _responseIsErrorModel(context, response);
    if (validationResult == true) {
      NavigatorUtils.pushReplacement(context, redirect);
    }
    return validationResult;
  }

  String resolveOnChaged(
      TextEditingController _controller, bool _submitted, String text) {
    return _controller.text.isEmpty && _submitted
        ? _controller.text = text
        : _controller.text;
  }

  String? resolveErrorText({
    controller = TextEditingController,
    submitted = bool,
    errorMessage = String,
  }) {
    return controller.text.isEmpty && submitted
        ? errorMessage
        : null;
  }

  Widget notFoundWidgetRedirect(
      BuildContext context, String message, String nextScreen) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: Text(
              message,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButtonWidget(
              buttonText: "Novo",
              textSize: 18,
              radioBorder: 20,
              horizontalPadding: 30,
              verticalPadding: 10,
              textColor: Colors.white,
              buttonColor: Colors.blue,
              onPressed: () {
                NavigatorUtils.pushNamed(context, nextScreen);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserEmail() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.getString("userEmail") != null
                ? snapshot.data!.getString("userEmail")!
                : "",
            style: const TextStyle(fontSize: 16),
          );
        }
        return const Text("");
      },
    );
  }

  Container getEditIcon(BuildContext context, Widget editScreen) {
    return Container(
      padding: const EdgeInsets.only(left: 7),
      child: GestureDetector(
        child: const Icon(
          LineIcons.edit,
          color: Colors.black,
          size: 30,
        ),
        onTap: () {
          NavigatorUtils.push(context, editScreen);
        },
      ),
    );
  }

  Container getTrashIcon() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: GestureDetector(
        child: const Icon(
          LineIcons.alternateTrash,
          size: 30,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    );
  }

  GestureDetector getDescricao(
      BuildContext context, Widget nextScreen, String descricao) {
    return GestureDetector(
      onTap: () => NavigatorUtils.push(context, nextScreen),
      child: Text(
        descricao.toUpperCase(),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget getQtdeModel(String qtdeText, Future<List<dynamic>> futureList) {
    return FutureBuilder(
        future: futureList,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (onHasValue(snapshot)) {
            String controller = snapshot.data!.length > 1 ? "s" : "";
            return Text(
                snapshot.data!.length.toString() + " $qtdeText$controller");
          }
          if (onDoneRequestWithEmptyValue(snapshot)) {
            return Text("0 $qtdeText");
          }
          if (onError(snapshot)) {
            return ErrorHandler.getDefaultErrorMessage(
                context, ErrorMessage.serverError);
          }
          return Text("");
        });
  }

  bool onHasValue(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        (snapshot.hasData);
  }

  bool onDoneRequestWithEmptyValue(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.connectionState == ConnectionState.done &&
        snapshot.data != null &&
        snapshot.data!.isEmpty;
  }

  bool onError(AsyncSnapshot<dynamic> snapshot) {
    return snapshot.hasError;
  }
}
