import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/AlertaEnvio.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/services/alertaenvio_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class MicroCard extends StatefulWidget {
  const MicroCard({required this.alert, required this.colorestado, Key? key});
  final AlertResponse alert;
  final Color colorestado;

  @override
  State<MicroCard> createState() => _MicroCardState();
}

class _MicroCardState extends State<MicroCard> {
  Color mycolor = Colors.green.shade900;
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
                                widget.alert.fecha != null
                                    ? TextSpan(
                                        text: '\n' '\n' +
                                            'Fecha: ' +
                                            widget.alert.fecha
                                                .toString()
                                                .substring(0, 10) +
                                            "       hora: " +
                                            widget.alert.hora.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(255, 3, 32, 4),
                                          height: 1.5,
                                        ),
                                      )
                                    : const TextSpan(
                                        text: '\n' + ' 0:0',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          height: 1.5,
                                        ),
                                      ),
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
                              text: widget.alert.description.substring(0, 80) +
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
