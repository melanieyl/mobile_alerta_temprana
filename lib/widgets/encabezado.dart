import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

import 'package:mobile_alerta_temprana/widgets/headers.dart';

class Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              IconHeader(
                titulo: 'Alerta Temprana SCZ',
                logo: 'imgs/escudo_scz.png',
                logo2: 'imgs/escudo_scz2.png',
                color1: Color.fromARGB(255, 49, 184, 31),
                color2: Color.fromARGB(255, 189, 255, 172),
                grosor: responsive.hp(35),
              ),
            ],
          ),
          Positioned(
              right: 0,
              top: 45,
              child: RawMaterialButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15.0),
                  child:
                      FaIcon(FontAwesomeIcons.ellipsisV, color: Colors.white)))
        ],
      ),
    );
  }
}
