import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';

class Alertas extends StatefulWidget {
  const Alertas({required this.alert, super.key});
  final Alert alert;

  @override
  State<Alertas> createState() => _AlertasState();
}

class _AlertasState extends State<Alertas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('melanie')),
    );
  }
}
