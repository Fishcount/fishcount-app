import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/exceptionHandler/ErrorModel.dart';
import 'package:fishcount_app/handler/ErrorHandler.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../constants/exceptions/ErrorMessage.dart';
import '../../handler/AsyncSnapshotHander.dart';
import '../generic/AbstractController.dart';
import '../tank/TankScreen.dart';
import 'BatchForm.dart';
import 'BatchScreen.dart';
import 'BatchService.dart';

class BatchController extends AbstractController {
  Future<dynamic> salvarLote(
      BuildContext context, BatchModel? managedLote, String nomeLote) async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return saveWithApi(managedLote, nomeLote, context);
    }
    return saveLocal(managedLote, nomeLote, context);
  }

  Future<dynamic> saveLocal(
      BatchModel? managedLote, String nomeLote, BuildContext context) async {
    if (managedLote != null) {
      return LoteRepository().update(context, managedLote);
    }
    BatchModel lote = BatchModel(null, nomeLote, null);
    return LoteRepository().save(context, lote);
  }

  Future<dynamic> saveWithApi(
      BatchModel? managedLote, String nomeLote, BuildContext context) {
    if (managedLote != null) {
      managedLote.descricao = nomeLote;
      return resolverSalvarOrAtualizar(context, managedLote);
    }
    return resolverSalvarOrAtualizar(context, BatchModel(null, nomeLote, null));
  }

  Future<dynamic> resolverSalvarOrAtualizar(
      BuildContext context, BatchModel managedLote) async {
    dynamic response = await BatchService().saveOrUpdate(managedLote);

    if (response is BatchModel) {
      NavigatorUtils.pushReplacement(context, const BatchScreen());
    }
    if (response is ErrorModel) {
      return ErrorHandler.getDefaultErrorMessage(context, response.message);
    }
  }
}
