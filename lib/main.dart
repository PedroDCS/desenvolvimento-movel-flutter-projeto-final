import 'package:flutter/material.dart';
import 'package:fluxo/splash1.dart';

Future<void> main() async {
  // it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: "Fluxo Caixa",
      debugShowCheckedModeBanner: false,
      home: Splash1()));
}
