import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';
import 'package:mobile_alerta_temprana/pages/sendNotification/form_page.dart';
import 'package:mobile_alerta_temprana/pages/show_alerts/alert.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'package:trip_planner/models/specific_line.dart';
// import 'package:trip_planner/providers/position_provider.dart';
// import 'package:trip_planner/views/map_view.dart';

class MicrosCard extends StatelessWidget {
  MicrosCard({
    required this.alert,
    this.dataComplete = false,
    this.index,
  });

  Alert alert;
  bool dataComplete;
  int? index;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-----------------------------
          // Card Tab
          //-----------------------------
          Align(
            heightFactor: .8,
            alignment: Alignment.centerLeft,
            child: Container(
              height: responsive.hp(5),
              width: responsive.wp(15),
              decoration: BoxDecoration(
                color: (alert.estado.nombre == 'Critico')
                    ? alert.estado.rojo
                    : ((alert.estado.nombre == 'Muy alto')
                        ? alert.estado.naranja
                        : ((alert.estado.nombre == 'Moderado')
                            ? alert.estado.amarillo
                            : (alert.estado.nombre == 'Bajo')
                                ? alert.estado.verde
                                : Colors.black)),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          //-----------------------------
          // Card Body
          //-----------------------------
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: (alert.estado.nombre == 'Critico')
                    ? alert.estado.rojo
                    : ((alert.estado.nombre == 'Muy alto')
                        ? alert.estado.naranja
                        : ((alert.estado.nombre == 'Moderado')
                            ? alert.estado.amarillo
                            : (alert.estado.nombre == 'Bajo')
                                ? alert.estado.verde
                                : Colors.white)),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              //-----------------------------
              // Card Body
              //-----------------------------
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------------------
                    // Name and fecha
                    //---------------------------
                    SizedBox(height: responsive.hp(2)),
                    Row(
                      children: [
                        // const Icon(
                        //   Icons.notifications,
                        //   color: Colors.blueAccent,
                        //   size: 40,
                        // ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: alert.nombre,
                              children: [
                                TextSpan(
                                  text: '\n' +
                                      alert.fecha.toString().substring(0, 10) +
                                      "       hora: " +
                                      alert.fecha.toString().substring(11, 16),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5,
                                  ),
                                )
                              ],
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              //fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //---------------------------
                    // estado
                    //---------------------------
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       Icons.warning,
                    //       size: 40,
                    //     ),
                    //     const SizedBox(width: 10),
                    //     SizedBox(
                    //       width: 250,
                    //       child: Text(
                    //         alert.estado.nombre,
                    //         style: const TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.red,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    //---------------------------
                    // Phone detalle
                    //---------------------------
                    SizedBox(height: responsive.hp(3)),
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 40,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: alert.detalle.substring(0, 70) + ' ...',
                            ),
                            style: const TextStyle(
                              fontSize: 16,

                              //fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //---------------------------
                    // Imagen
                    //---------------------------
                    // Row(
                    //   children: [
                    //     FaIcon(
                    //       FontAwesomeIcons.camera,
                    //       size: 40,
                    //       color: Colors.yellow[900],
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Container(
                    //       width: 150,
                    //       height: 150,
                    //       child: Center(
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(15),
                    //           child: Image.asset(alert.fotos.first.path),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: responsive.hp(4)),
                    Center(
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 40.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_)
                                      // => Alertas(
                                      //       alerta: alert,
                                      //     )
                                      =>
                                      FormularioEmergencia()));
                        },
                        color: (alert.estado.nombre == 'Critico')
                            ? alert.estado.rojo
                            : ((alert.estado.nombre == 'Muy alto')
                                ? alert.estado.naranja
                                : ((alert.estado.nombre == 'Moderado')
                                    ? alert.estado.amarillo
                                    : (alert.estado.nombre == 'Bajo')
                                        ? alert.estado.verde
                                        : Colors.white)),
                        child: const Text('Ver mas',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),

                    // Column(
                    //   children: [
                    //     Center(
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 150,
                    //       height: 50,
                    //       // padding: EdgeInsets.symmetric(vertical: 10),
                    //       // margin:
                    //       //     EdgeInsets.only(top: 450, right: 100, left: 100),
                    //       decoration: BoxDecoration(
                    //         color: Colors.black,
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(10),
                    //           topRight: Radius.circular(10),
                    //           bottomLeft: Radius.circular(10),
                    //           bottomRight: Radius.circular(10),
                    //         ),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: (alert.estado.nombre == 'Critico')
                    //                 ? alert.estado.rojo
                    //                 : ((alert.estado.nombre == 'Muy alto')
                    //                     ? alert.estado.naranja
                    //                     : ((alert.estado.nombre == 'Moderado')
                    //                         ? alert.estado.amarillo
                    //                         : (alert.estado.nombre == 'Bajo')
                    //                             ? alert.estado.verde
                    //                             : Colors.white)),
                    //             spreadRadius: 5,
                    //             blurRadius: 7,
                    //             // changes position of shadow
                    //           ),
                    //         ],
                    //       ),
                    //       child: ListTile(
                    //         title: const Text(
                    //           "Ver más",
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               fontSize: 17,
                    //               color: Colors.white,
                    //               fontStyle: FontStyle.italic),
                    //         ),
                    //         onTap: () {
                    //           // final positionProvider =
                    //           //     Provider.of<PositionProvider>(context,
                    //           //         listen: false);
                    //           // positionProvider.recorridoSelected =
                    //           //     micros.id;
                    //           // Navigator.push(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (_) => MapView(
                    //           //             0,
                    //           //             99,
                    //           //             positionProvider.startPosition,
                    //           //             positionProvider.endPosition,
                    //           //             null)));
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
