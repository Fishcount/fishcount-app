import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/InstallmentPaymentModel.dart';
import 'package:fishcount_app/model/PixModel.dart';
import 'package:fishcount_app/model/enums/EnumMes.dart';
import 'package:fishcount_app/model/enums/EnumStatusPagamento.dart';
import 'package:fishcount_app/modules/financial/pix/PixService.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/AlertDialogBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../utils/AnimationUtils.dart';
import '../../generic/AbstractController.dart';
import 'PaymentInstallmentService.dart';

class PaymentInstallmentController extends AbstractController {
  static final PaymentInstallmentService pagamentoParcelaService =
      PaymentInstallmentService();

  static final PixService _pixService = PixService();

  static parcelasList(BuildContext context, int pagamentoId) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: pagamentoParcelaService.buscarPagamentosParcela(pagamentoId),
        builder:
            (context, AsyncSnapshot<List<InstallmentPaymentModel>> snapshot) {
          return AsyncSnapshotHandler(
            asyncSnapshot: snapshot,
            widgetOnError: const Text("Erro"),
            widgetOnWaiting: AnimationUtils.progressiveDots(size: 50.0),
            widgetOnEmptyResponse: _onEmptyResponse(),
            widgetOnSuccess: _onSuccessfulRequest(context, snapshot),
          ).handler();
        },
      ),
    );
  }

  static Text _onEmptyResponse() {
    return const Text("Não foi possível encontrar nenhuma parcela para você.");
  }

  static SingleChildScrollView _onSuccessfulRequest(BuildContext context,
      AsyncSnapshot<List<InstallmentPaymentModel>> snapshot) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data != null ? snapshot.data!.length : 0,
            itemBuilder: (context, index) {
              final InstallmentPaymentModel parcela = snapshot.data![index];
              final String mesParcela = parcela.dueDate.split('/')[1];
              final String anoParcela = parcela.dueDate.split('/')[2];
              const Color borderColor = Colors.black26;
              final Color? backGroundColor = Colors.grey[100];

              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  height: 190,
                  decoration: BoxDecoration(
                    color: backGroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border(
                      bottom: BorderSide(
                        color: borderColor,
                      ),
                      left: BorderSide(
                        color: borderColor,
                      ),
                      right: BorderSide(
                        color: borderColor,
                      ),
                      top: BorderSide(
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                MonthHandler(monthNumber: mesParcela).handle() +
                                    " | $anoParcela",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                parcela.paymentStatus,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: EnumStatusPagamentoHandler
                                      .getColorByStatus(
                                          parcela.paymentStatus),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: const Divider(
                            color: Colors.blue,
                            height: 5,
                            thickness: 2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Multa por atraso: R\$ ' +
                                          parcela.increase.toString() +
                                          '0',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Desconto: R\$ ' +
                                          parcela.discount.toString() +
                                          '0',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Data Vencimento: ' +
                                          parcela.dueDate,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Valor total: R\$ ' +
                                          parcela.value.toString() +
                                          '0',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            parcela.paymentStatus != "FINALIZADO"
                                ? Container(
                                    padding: const EdgeInsets.only(top: 90),
                                    child: ElevatedButtonWidget(
                                      buttonColor: Colors.blue,
                                      buttonText: "Pagar",
                                      radioBorder: 10,
                                      textColor: Colors.white,
                                      textSize: 15,
                                      onPressed: () =>
                                          _showQrCodePix(context, parcela.id!),
                                    ),
                                  )
                                : const Text(""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  static Future<dynamic> _showQrCodePix(
      BuildContext context, int parcelaId) async {
    return AlertDialogBuilder(
      title: "Pix copia e cola",
      description:
          "Copie o código abaixo, abra o aplicativo do seu banco, cole na opção 'pix copia e cola' e confirme o pagamento",
      mainAxisAlignment: MainAxisAlignment.center,
      bottomElement: Container(
        child: FutureBuilder(
          future: _pixService.buscarQRCodePorParcela(parcelaId),
          builder: (BuildContext context, AsyncSnapshot<PixModel> snapshot) {
            PixModel? pixModel = snapshot.data != null ? snapshot.data! : null;
            return AsyncSnapshotHandler(
                    asyncSnapshot: snapshot,
                    widgetOnError: const Text("Erro"),
                    widgetOnWaiting: AnimationUtils.progressiveDots(size: 50.0),
                    widgetOnEmptyResponse: _onEmptyResponse(),
                    widgetOnSuccess: _dialogQrCode(pixModel, context),
                    )
                .handler();
          },
        ),
      ),
    ).build(context);
  }

  static _dialogQrCode(PixModel? pixModel, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: TextFieldWidget(
            controller: TextEditingController(),
            hintText: pixModel == null ? '' : pixModel.qrCode,
            focusedBorderColor: Colors.purple,
            iconColor: Colors.blue,
            obscureText: false,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            child: const Icon(Icons.copy),
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: pixModel == null ? '' : pixModel.qrCode));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Chave copiada!"),
                  backgroundColor: Colors.green[400],
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "",
                    onPressed: () {},
                  ),
                ),
              );
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
