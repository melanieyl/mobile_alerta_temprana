import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/home.dart';
import 'package:mobile_alerta_temprana/test.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: const SafeArea(child: Text('Hola mundo ')),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              onPressed: () {
                // Navigator.push(context, route)
                
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page2(),
                    ));
              }),
        ));
  }
}
