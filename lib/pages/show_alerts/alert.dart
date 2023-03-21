import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/helpers/progress_indicator_fachero.dart';
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
  List<AlertResponse> alerts = [];
 

  @override
  void initState() {
    AlertasServices.getAlerts().then((listAlerts) => {
          setState(() {
            alerts = listAlerts;
          }),
        });
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return alerts.isNotEmpty
        ? Scaffold(
            body: Center(child: ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
            return ListTile(
              title: Text(alerts[index].nombre),
            );
          })))
        : IndicatorFachero();
  }
}
