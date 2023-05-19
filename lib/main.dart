import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/home.dart';
import 'package:mobile_alerta_temprana/test.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
