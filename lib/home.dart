// import 'package:alerta_temprana_scz/Send%20Notification/form_page.dart';
// import 'package:alerta_temprana_scz/pages/show_alerts/implementation_cards/ui/contact_list_page.dart';
// import 'package:alerta_temprana_scz/pages/show_alerts/show_categories.dart';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:mobile_alerta_temprana/widgets/boton_gordo.dart';
import 'package:mobile_alerta_temprana/widgets/encabezado.dart';
import 'package:mobile_alerta_temprana/widgets/headers.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final void Function()? onTap;
  final Color color1;
  final Color color2;

  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.onTap);
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const IconData copyright =
      IconData(0xe198, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final items = <ItemBoton>[
      ItemBoton(
        Icons.notification_add,
        'Enviar Alerta',
        Colors.yellow.shade700,
        Colors.yellowAccent,
        () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (_) => const FormularioEmergencia()));
        },
      ),
      ItemBoton(FontAwesomeIcons.warning, 'Mostrar Alertas', Colors.red,
          Colors.orangeAccent, () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (_) => MicrosListPage(distances)));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => CategoriesPage()));
      }),
      ItemBoton(
        FontAwesomeIcons.whatsapp,
        'Contáctate con nostros con un toque',
        Colors.green.shade700,
        Colors.green.shade400,
        () {},
      ),
      ItemBoton(
        Icons.mail,
        'Difundir',
        Colors.grey.shade800,
        Colors.grey.shade400,
        () {},
      ),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: Duration(milliseconds: 250),
              child: BotonGordo(
                icon: item.icon,
                texto: item.texto,
                color1: item.color1,
                color2: item.color2,
                onPress: item.onTap,
              ),
            ))
        .toList();

    return Scaffold(
      // backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: responsive.hp(20),
                ),
                ...itemMap,
                Center(child: Text("Emergencias Gobernación: 800148139")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 220,
                        child: Icon(
                            IconData(0xe198, fontFamily: 'MaterialIcons'))),
                    Text("Solution "),
                    FaIcon(FontAwesomeIcons.heart)
                  ],
                ),
              ],
            ),
          ),
          Encabezado()
        ],
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "MainButton",
        backgroundColor: Colors.green.shade900,
        child: Icon(Icons.call),
        onPressed: () {
          // socketService.emit('emitir-mensaje',
          //     {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
          // Navigator.pushNamed(context, 'usuarios');
        },
      ),
    );
  }
}

class BotonGordoTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotonGordo(
      icon: FontAwesomeIcons.carCrash,
      texto: 'Motor Accident',
      color1: Color(0xff6989F5),
      color2: Color(0xff906EF5),
      onPress: () {
        print('Click!');
      },
    );
  }
}
