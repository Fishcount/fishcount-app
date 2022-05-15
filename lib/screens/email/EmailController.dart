import 'package:fishcount_app/model/EmailModel.dart';
import 'package:fishcount_app/screens/generic/AbstractController.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:flutter/cupertino.dart';

class EmailController extends AbstractController {
  Future<dynamic> salvarEmail(
      BuildContext context, int? emailId, String? email) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      print("chamar api");
    }
  }


}
