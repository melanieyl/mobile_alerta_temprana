import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/AlertaEnvio.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/services/alertaenvio_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class MicroCard extends StatefulWidget {
  const MicroCard({required this.alert, required this.colorestado, super.key});
  final AlertResponse alert;
  final Color colorestado;

  @override
  State<MicroCard> createState() => _MicroCardState();
}

class _MicroCardState extends State<MicroCard> {
  List<AlertaEnvioResponse> alertEnvio = [];
  Color mycolor = Colors.purple;
  @override
  // void initState() {
  //   // ignore: unnecessary_null_comparison

  //   AlertaEnvioServices()
  //       .getAlertaEnvio(widget.alert.id)
  //       .then((listAlertaEnvio) => {
  //             setState(() {
  //               alertEnvio = listAlertaEnvio;
  //             }),
  //           });

  //   print('laertenvio' + '$alertEnvio.id');
  //   if (alertEnvio.isNotEmpty) {
  //     mycolor = hexToColor(alertEnvio.last.color);
  //   }
  //   super.initState();
  // }

  // Color hexToColor(String code) {
  //   return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  // }

  // Color existecolor() {
  //   if (alertEnvio.isEmpty) {
  //     return Colors.white;
  //   }
  //   return hexToColor(alertEnvio.last.color);
  // }

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
                color: mycolor,
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
                color: mycolor,
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
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: widget.alert.nombre,
                              children: [
                                TextSpan(
                                  text: '\n' +
                                      '\n' +
                                      'Fecha: ' +
                                      widget.alert.fecha
                                          .toString()
                                          .substring(0, 10) +
                                      "       hora: " +
                                      widget.alert.hora.toString(),
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

                    SizedBox(height: responsive.hp(3)),

                    Row(
                      children: [
                        const Icon(
                          Icons.description,
                          size: 40,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: widget.alert.description.substring(0, 70) +
                                  ' ...',
                            ),
                            style: const TextStyle(
                              fontSize: 16,

                              //fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: responsive.hp(4)),
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

// class MicrosCard extends StatelessWidget {
//   MicrosCard({
//     required this.alert,
//     this.dataComplete = false,
//   });

//   AlertResponse alert;
//   bool dataComplete;

//   @override
//   Widget build(BuildContext context) {
//     final Responsive responsive = Responsive.of(context);
//     return Material(
//       color: Colors.transparent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           //-----------------------------
//           // Card Tab
//           //-----------------------------
//           Align(
//             heightFactor: .8,
//             alignment: Alignment.centerLeft,
//             child: Container(
//               height: responsive.hp(5),
//               width: responsive.wp(15),
//               decoration: BoxDecoration(
//                 color: Colors.deepPurple,
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(10),
//                 ),
//               ),
//               child: const Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           //-----------------------------
//           // Card Body
//           //-----------------------------
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(15),
//               decoration: const BoxDecoration(
//                 color: Colors.deepPurple,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               //-----------------------------
//               // Card Body
//               //-----------------------------
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //---------------------------
//                     // Name and fecha
//                     //---------------------------
//                     SizedBox(height: responsive.hp(2)),
//                     Row(
//                       children: [
//                         const SizedBox(width: 10),
//                         Flexible(
//                           child: Text.rich(
//                             TextSpan(
//                               text: alert.nombre,
//                               children: [
//                                 TextSpan(
//                                   text: '\n' +
//                                       '\n' +
//                                       'Fecha: ' +
//                                       alert.fecha.toString().substring(0, 10) +
//                                       "       hora: " +
//                                       alert.hora.toString(),
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.normal,
//                                     height: 1.5,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             style: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               //fontStyle: FontStyle.normal,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: responsive.hp(3)),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.description,
//                           size: 40,
//                           color: Colors.black54,
//                         ),
//                         const SizedBox(width: 10),
//                         Flexible(
//                           child: Text.rich(
//                             TextSpan(
//                               text: alert.description.substring(0, 70) + ' ...',
//                             ),
//                             style: const TextStyle(
//                               fontSize: 16,

//                               //fontStyle: FontStyle.normal,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     SizedBox(height: responsive.hp(4)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
