import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/PagamentoModel.dart';
import 'package:fishcount_app/model/PlanoModel.dart';
import 'package:fishcount_app/screens/plano/PlanoController.dart';
import 'package:fishcount_app/service/PlanoService.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';

class FinanceiroScreen extends StatefulWidget {
  final List<PagamentoModel>? pagamentos;

  const FinanceiroScreen({
    Key? key,
    this.pagamentos,
  }) : super(key: key);

  @override
  State<FinanceiroScreen> createState() => _FinanceiroScreenState();
}

class _FinanceiroScreenState extends State<FinanceiroScreen> {
  bool _showPagamentos() {
    return widget.pagamentos != null && widget.pagamentos!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomSheet: CustomBottomSheet.getCustomBottomSheet(
          context, AppPaths.cadastroLotePath),
      body: Container(
        padding:
            const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
        child: Column(
          children: [
            DividerWidget(
              widgetBetween: Text(
                _showPagamentos() ? "Pagamentos" : "Financeiro",
                style: const TextStyle(color: Colors.blue, fontSize: 17),
              ),
              height: 1,
              thikness: 1,
              color: Colors.blue,
              paddingLeft: 12,
              paddingRight: 12,
            ),
            _showPagamentos()
                ? Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Mês"),
                              Text("|"),
                              Text("Vencimento"),
                              Text("|"),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text("Valor"),
                              ),
                              Text("|"),
                              Text("Status"),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: ListView.builder(
                              itemCount: widget.pagamentos!.length,
                              itemBuilder: (BuildContext context, index) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                        color: Colors.black26, width: 1),
                                    right: BorderSide(
                                        color: Colors.black26, width: 1),
                                    left: BorderSide(
                                        color: Colors.black26, width: 1),
                                    bottom: BorderSide(
                                        color: Colors.blueAccent, width: 2),
                                  )),
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: ListTile(
                                    // leading: Text("DEZ"),
                                    trailing: Text(
                                      widget.pagamentos![index].statusPagamento,
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 15,
                                      ),
                                    ),
                                    title: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Dez"),
                                          Text("|"),
                                          Text("01/01/2021"),
                                          Text("|"),
                                          Text("Valor"),
                                          Text("|"),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: FutureBuilder(
                      future: PlanoService().listarPlanos(),
                      builder:
                          (context, AsyncSnapshot<List<PlanoModel>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          if (snapshot.hasData && snapshot.data!.isEmpty) {
                            return const Text(
                                "Não foi possível encontrar nenhum plano disponivel");
                          }
                          return PlanoController()
                              .listarPlanos(snapshot.data!, context);
                        }
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
