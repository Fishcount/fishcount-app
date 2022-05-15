import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:fishcount_app/screens/login/LoginScreen.dart';
import 'package:fishcount_app/screens/lote/LotesScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      AppPaths.loginPath: (context) => AppPaths.paths[AppPaths.loginPath]!,
      AppPaths.lotesPath: (context) => AppPaths.paths[AppPaths.lotesPath]!,
      AppPaths.tanquesPath: (context) => AppPaths.paths[AppPaths.tanquesPath]!,
      AppPaths.cadastroUsuarioPath: (context) =>
          AppPaths.paths[AppPaths.cadastroUsuarioPath]!,
      AppPaths.cadastroTanquePath: (context) =>
          AppPaths.paths[AppPaths.cadastroTanquePath]!,
      AppPaths.cadastroLotePath: (context) =>
          AppPaths.paths[AppPaths.cadastroLotePath]!,
    },
    title: 'FishCount',
    debugShowCheckedModeBanner: false,
    checkerboardOffscreenLayers: false,
    color: Colors.white,
    home: const LoginScreen(),
  ));
}
