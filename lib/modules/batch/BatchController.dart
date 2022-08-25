import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:flutter/material.dart';

import '../../widgets/TextFieldWidget.dart';
import '../../widgets/buttons/ElevatedButtonWidget.dart';
import '../generic/AbstractController.dart';
import 'BatchService.dart';

class BatchController extends AbstractController {
  final BatchService _batchService = BatchService();
  final LoteRepository _loteRepository = LoteRepository();
  final ConnectionUtils _connectionUtils = ConnectionUtils();

  Future<dynamic> saveBatch(BuildContext context, String nomeLote) async {
    final isConnected = await _connectionUtils.isConnected();
    BatchModel batchModel = _createBatchModel(nomeLote);
    if (isConnected) {
      return APIsave(context, batchModel);
    }
    return localSave(batchModel, context);
  }

  Future<dynamic> updateBatch(
      BuildContext context, BatchModel managedLote) async {
    bool isConnected = await _connectionUtils.isConnected();
    if (isConnected) {
      return APIUpdate(context, managedLote);
    }
    return localSave(managedLote, context);
  }

  Future<dynamic> localSave(BatchModel batchModel, BuildContext context) async {
    return _loteRepository.save(context, batchModel);
  }

  Future<dynamic> APIsave(BuildContext context, BatchModel managedLote) async {
    return await _batchService.save(managedLote);
  }

  Future<dynamic> APIUpdate(
      BuildContext context, BatchModel managedLote) async {
    return await _batchService.update(managedLote);
  }

  BatchModel _createBatchModel(String nomeLote) {
    return BatchModel(null, nomeLote, null);
  }

  openBatchRegisterModal(
      BuildContext context,
      TextEditingController _batchNameController,
      AnimationController _animationController,
      BatchModel? batchModel) {
    final bool _isUpdate = batchModel != null;

    return showModalBottomSheet<void>(
      context: context,
      transitionAnimationController: _animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                _isUpdate ? "Atualizar Lote" : "Cadastrar novo lote",
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFieldWidget(
                controller: _batchNameController,
                hintText: 'Nome do lote',
                focusedBorderColor: Colors.blueGrey,
                iconColor: Colors.blueGrey,
                obscureText: false,
                labelText: 'Nome do lote',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: "Cancelar",
                    buttonColor: Colors.blue,
                    onPressed: () => Navigator.pop(context),
                    textSize: 15,
                    textColor: Colors.white,
                    radioBorder: 10,
                    horizontalPadding: 20,
                    verticalPadding: 10,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButtonWidget(
                    buttonText: "Confirmar",
                    buttonColor: Colors.green,
                    onPressed: () => _isUpdate
                        ? updateBatch(context, batchModel)
                        : saveBatch(context, _batchNameController.text),
                    textSize: 15,
                    textColor: Colors.white,
                    radioBorder: 10,
                    horizontalPadding: 20,
                    verticalPadding: 10,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
