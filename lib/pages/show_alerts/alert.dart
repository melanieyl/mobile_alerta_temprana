import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/services/alertas_service.dart';

class Alertas extends StatefulWidget {
  const Alertas({required this.alert, super.key});
  final Alert alert;

  @override
  State<Alertas> createState() => _AlertasState();
}

class _AlertasState extends State<Alertas> {
  final List<AlertResponse> alerts = [];
  final alertservice = new AlertasServices();

  void loadData() async {
    final alerts = await alertservice.getAlerts();
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    // alerts.forEach((element) {
    //   print(element);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return alerts.isEmpty
        ? CircularProgressIndicator()
        : Scaffold(
            body: SafeArea(
              child: ListView.builder(
                  itemCount: alerts.length,
                  itemBuilder: (contex, index) {
                    return Text(alerts[index].nombre.toString());
                  }),
            ),
          );
  }
}
