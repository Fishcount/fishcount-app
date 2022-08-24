import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/constants/exceptions/ErrorMessage.dart';
import 'package:fishcount_app/handler/AsyncSnapshotHander.dart';
import 'package:fishcount_app/model/BatchModel.dart';
import 'package:fishcount_app/model/TankModel.dart';
import 'package:fishcount_app/repository/TanqueRepository.dart';
import 'package:fishcount_app/utils/ConnectionUtils.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TankForm.dart';
import 'TankService.dart';

class TankScreen extends StatefulWidget {
  final BatchModel lote;

  const TankScreen({Key? key, required this.lote}) : super(key: key);

  @override
  State<TankScreen> createState() => _TankScreenState();
}

class _TankScreenState extends State<TankScreen> {
  final TextEditingController _pesquisaController = TextEditingController();

  Future<List<TankModel>> listTanks() async {
    bool isConnected = await ConnectionUtils().isConnected();
    if (isConnected) {
      return TankService().listarTanquesFromLote(widget.lote);
    }
    return TanqueRepository().listarTanques(context, widget.lote.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
        context,
        TankForm(
          lote: widget.lote,
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            children: [
              TextFieldWidget(
                controller: _pesquisaController,
                focusedBorderColor: Colors.white30,
                iconColor: Colors.blueGrey,
                prefixIcon: const Icon(Icons.search),
                hintText: "Pesquisar",
                obscureText: false,
              ),
              const DividerWidget(
                textBetween: "TANQUES",
                height: 40,
                thikness: 2.5,
                paddingLeft: 10,
                paddingRight: 10,
                color: Colors.blue,
                textColor: Colors.black,
                isBold: true,
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: listTanks(),
                    builder:
                        (context, AsyncSnapshot<List<TankModel>> snapshot) {
                      return AsyncSnapshotHandler(
                        asyncSnapshot: snapshot,
                        widgetOnError: const Text(""),
                        widgetOnWaiting: const CircularProgressIndicator(),
                        widgetOnEmptyResponse: _notFoundWidget(context),
                        widgetOnSuccess:
                            _tankList(context, snapshot.data, widget.lote),
                      ).handler();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _notFoundWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: const Text(
              ErrorMessage.usuarioSemTanque,
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
                NavigatorUtils.push(
                  context,
                  TankForm(
                    lote: widget.lote,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tankList(
      BuildContext context, List<TankModel>? tanques, BatchModel lote) {
    if (tanques == null) {
      return _notFoundWidget(context);
    }
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.7,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tanques.length,
          itemBuilder: (context, index) {
            TankModel tanque = tanques[index];
            return Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              height: 70,
              decoration: const BoxDecoration(
                //  borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Colors.black26,
                  ),
                  right: BorderSide(
                    color: Colors.black26,
                  ),
                  top: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            NavigatorUtils.push(
                              context,
                              TankForm(
                                tanque: tanque,
                                lote: lote,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              tanque.description.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          right: 7,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.edit,
                            color: Colors.black,
                            size: 25,
                          ),
                          onTap: () {
                            NavigatorUtils.push(
                              context,
                              TankForm(
                                tanque: tanque,
                                lote: lote,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 6,
                          top: 12,
                          bottom: 12,
                        ),
                        width: 30,
                        decoration: const BoxDecoration(
                          //color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: const Icon(
                            LineIcons.trash,
                            color: Colors.red,
                            size: 25,
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
