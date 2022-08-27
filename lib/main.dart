import 'package:firebase_core/firebase_core.dart';
import 'package:fishcount_app/constants/AppPaths.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'modules/login/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    routes: {
      AppPaths.loginPath: (context) => AppPaths.paths[AppPaths.loginPath]!,
      AppPaths.lotesPath: (context) => AppPaths.paths[AppPaths.lotesPath]!,
      AppPaths.cadastroUsuarioPath: (context) =>
          AppPaths.paths[AppPaths.cadastroUsuarioPath]!,
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
