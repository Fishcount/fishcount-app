import 'package:fishcount_app/screens/CadastroScreen.dart';
import 'package:fishcount_app/screens/LotesScreen.dart';
import 'package:fishcount_app/screens/TanquesScreen.dart';
import 'package:fishcount_app/screens/login/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/login': (context) => const LoginScreen(),
      '/cadastro': (context) => const CadastroScreen(),
      '/lotes': (context) => const LotesScreen(),
      '/tanques': (context) => const TanquesScreen(),
    },
    title: 'FishCount',
    debugShowCheckedModeBanner: false,
    checkerboardOffscreenLayers: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    home: const LoginScreen(),
  ));
}
