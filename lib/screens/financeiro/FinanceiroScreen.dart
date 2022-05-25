import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/model/LoteModel.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:fishcount_app/utils/NavigatorUtils.dart';
import 'package:fishcount_app/widgets/DividerWidget.dart';
import 'package:fishcount_app/widgets/DrawerWidget.dart';
import 'package:fishcount_app/widgets/TextFieldWidget.dart';
import 'package:fishcount_app/widgets/custom/CustomAppBar.dart';
import 'package:fishcount_app/widgets/custom/CustomBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FinanceiroScreen extends StatefulWidget {
  const FinanceiroScreen({Key? key}) : super(key: key);

  @override
  State<FinanceiroScreen> createState() => _FinanceiroScreenState();
}

class _FinanceiroScreenState extends State<FinanceiroScreen> {
  final TextEditingController _pesquisaController = TextEditingController();
  List<LoteModel> financeiro = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(),
      drawer: const DrawerWidget(),
      bottomNavigationBar: CustomBottomSheet.getCustomBottomSheet(
          context, AppPaths.cadastroLotePath),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
              textBetween: "FINANCEIRO",
              height: 40,
              thikness: 2.5,
              paddingLeft: 10,
              paddingRight: 10,
              color: Colors.blue,
              textColor: Colors.black,
              isBold: true,
            ),
            //TESTE DE CRIACAO TELAS
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                   onTap: (){
                     NavigatorUtils.pushReplacement(context,LotesScreen());
                   },
                    child: Container(
                      padding: const EdgeInsets.only(left: 25, top: 25),
                     // child: Text(

                      //),
                    ),

                  )
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

                    onTap: () {},
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
      ),
    );
  }
}
