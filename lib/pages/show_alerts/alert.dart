import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/helpers/progress_indicator_fachero.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/services/alertas_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class Alertas extends StatefulWidget {
  const Alertas({required this.alert, super.key});
  final AlertResponse alert;

  @override
  State<Alertas> createState() => _AlertasState();
}

class _AlertasState extends State<Alertas> {
  //List<AlertResponse> alerts = [];

  @override
  void initState() {
    // AlertasServices.getAlerts().then((listAlerts) => {
    //       setState(() {
    //         alerts = listAlerts;
    //       }),
    //     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   flexibleSpace: SafeArea(
      //       child: Text(
      //     widget.alert.nombre,
      //     style: TextStyle(fontSize: 30),
      //   )),
      //   backgroundColor: Colors.green[600],
      // ),
      body: SafeArea(
        child: Column(children: [
          Container(
            height: responsive.hp(15),
            width: responsive.wp(80),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Expanded(
                child: Center(
              child: Text(
                widget.alert.nombre,
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )),
          ),
          Container(
            child: Expanded(
                child: Text(
              widget.alert.description,
              style: TextStyle(fontStyle: FontStyle.normal),
              textAlign: TextAlign.center,
            )),
          )
        ]),
      ),
    );
  }
}
