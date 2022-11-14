import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/modules/batch/BatchScreen.dart';
import 'package:fishcount_app/repository/LoteRepository.dart';
import 'package:fishcount_app/utils/AnimationUtils.dart';
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
      return await apiSave(context, batchModel);
    }
    return await localSave(batchModel, context);
  }

  Future<dynamic> updateBatch(
      BuildContext context, BatchModel managedLote) async {
    bool isConnected = await _connectionUtils.isConnected();
    if (isConnected) {
      return apiUpdate(context, managedLote);
    }
    return localSave(managedLote, context);
  }

  Future<dynamic> localSave(BatchModel batchModel, BuildContext context) async {
    return _loteRepository.save(context, batchModel);
  }

  Future<dynamic> apiSave(BuildContext context, BatchModel managedLote) async {
    dynamic response = await _batchService.save(managedLote);
    return await afterRequestAlertDialog(
      context: context,
      response: response,
      redirect: const BatchScreen(),
    );
  }

  Future<dynamic> apiUpdate(
      BuildContext context, BatchModel managedLote) async {
    dynamic response = await _batchService.update(managedLote);
    return afterRequestAlertDialog(
      context: context,
      response: response,
      redirect: const BatchScreen(),
    );
  }

  BatchModel _createBatchModel(String nomeLote) {
    return BatchModel(null, nomeLote, null);
  }

  openBatchRegisterModal(
      Function(String) onChanged,
      BuildContext context,
      TextEditingController _batchNameController,
      AnimationController _animationController,
      BatchModel? batchModel) {
    final bool _isUpdate = batchModel != null;
    bool _submitted = false;
    bool loading = false;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      transitionAnimationController: _animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 650,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50, bottom: 20),
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
                      errorText: resolveErrorText(
                        submitted: _submitted,
                        controller: _batchNameController,
                        errorMessage: 'O nome do lote não pode estar vazio.',
                      ),
                      onChanged: (text) => setState(
                        () => resolveOnChaged(
                            _batchNameController, _submitted, text),
                      ),
                    ),
                  ),
                  loading
                      ? Container(
                          padding: const EdgeInsets.only(top: 30),
                          child: AnimationUtils.progressiveDots(size: 50.0),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 30),
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
                              padding: const EdgeInsets.only(top: 40),
                              child: ElevatedButtonWidget(
                                buttonText: "Confirmar",
                                buttonColor: Colors.green,
                                onPressed: () async {
                                  setState(() {
                                    _submitted = true;
                                  });
                                  if (_batchNameController.text.isNotEmpty) {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (_isUpdate) {
                                      batchModel.description =
                                          _batchNameController.text;
                                      updateBatch(context, batchModel);
                                      return;
                                    }
                                    await saveBatch(
                                        context, _batchNameController.text);
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
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
              ),
            );
          },
        );
      },
    );
  }
}
