import 'package:fishcount_app/constants/AppImages.dart';
import 'package:fishcount_app/widgets/buttons/ElevatedButtonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.cyan[400]!,
                  Colors.cyan[50]!,
                ],
              ),
            ),
            padding: const EdgeInsets.only(left: 85, right: 85),
            child: CircleAvatar(
              maxRadius: 70,
              minRadius: 50,
              child: Image.asset(ImagePaths.imageLogo),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: const SizedBox(
              child: Text(
                "Nome do caboclo",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              height: 20,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 5, bottom: 30),
            child: const SizedBox(
              child: Text(
                "emaildocaboclo@gmail.com",
                maxLines: 1,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              height: 20,
            ),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.person),
            title: Text("Meus dados"),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.monetization_on),
            title: Text("Financeiro"),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.support_agent),
            title: Text("Suporte"),
          ),
          const ListTile(
            isThreeLine: false,
            minVerticalPadding: 15,
            horizontalTitleGap: 15,
            leading: Icon(Icons.privacy_tip),
            title: Text("Politica de privacidade"),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 40, top: 220),
            child: ElevatedButtonWidget(
              buttonText: "Sair",
              buttonColor: Colors.cyan.shade600,
              textColor: Colors.white,
              textSize: 20,
              radioBorder: 50,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
