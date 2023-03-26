import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/helpers/progress_indicator_fachero.dart';
import 'package:mobile_alerta_temprana/models/AlertaEnvio.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/services/alertaenvio_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

import '../../widgets/card.dart';

class Alertas extends StatefulWidget {
  const Alertas({required this.alert, super.key});
  final AlertResponse alert;

  @override
  State<Alertas> createState() => _AlertasState();
}

class _AlertasState extends State<Alertas> {
  List<AlertaEnvioResponse> alertEnvio = [];
  final controller = PageController(initialPage: 0);
  int currentPage = 0;

  final int idalert = 4;
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    if (idalert != null) {
      AlertaEnvioServices().getAlertaEnvio(idalert).then((listAlertaEnvio) => {
            setState(() {
              alertEnvio = listAlertaEnvio;
            }),
          });
    } else {
      print('erros que no deberia ocurri');
    }
    print('$alertEnvio');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      drawer: alertEnvio.isNotEmpty
          ? Drawer(
              width: responsive.wp(20),
              child: Column(
                children: [
                  Container(
                    height: responsive.hp(50),
                    color: Colors.lightGreenAccent,
                  ),
                  Container(
                    child: ListView.builder(
                      itemCount: alertEnvio.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        AlertaEnvioResponse alertaenvio = alertEnvio[index];
                        Color myColor = hexToColor(alertaenvio.color);
                        return IconButton(
                          onPressed: () {
                            controller.animateToPage(index,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                            setState(() {
                              currentPage = index;
                              print('$index');
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.exclamationmark_shield_fill,
                            size: responsive.wp(15),
                            color: myColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ))
          : const CargandoSquare(),
      body: SafeArea(
        child: alertEnvio.isNotEmpty
            ? Column(
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.alert.nombre.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    child: PageView.builder(
                      itemCount: alertEnvio.length,
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                        AlertaEnvioResponse alertaenvio = alertEnvio[index];
                        Color myColor = hexToColor(alertaenvio.color);
                        return Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    elevation: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Column(
                                        children: <Widget>[
                                          Image(
                                            image: NetworkImage(
                                                'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Text(alertaenvio.fecha
                                                    .toString()
                                                    .substring(0, 11) +
                                                alertaenvio.hora
                                                    .substring(0, 5)),
                                          ),
                                        ],
                                      ),
                                    )),
                                Cardenvio(
                                    titulo: alertaenvio.description,
                                    sizetext: 15),
                              ],
                              //trailing: Text(alertaenvio.fecha.toString()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const CargandoSquare(),
      ),
    );
  }
}
