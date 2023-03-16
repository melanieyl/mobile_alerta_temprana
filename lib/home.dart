import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alerta_temprana/pages/categories/show_categories.dart';
import 'package:mobile_alerta_temprana/pages/sendNotification/form_page.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:mobile_alerta_temprana/widgets/boton_gordo.dart';
import 'package:mobile_alerta_temprana/widgets/boton_link.dart';
import 'package:mobile_alerta_temprana/widgets/encabezado.dart';

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
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FormularioEmergencia()));
        },
      ),
      ItemBoton(FontAwesomeIcons.warning, 'Mostrar Alertas', Colors.red,
          Colors.orangeAccent, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => CategoriesPage()));
      }),
      ItemBoton(
        FontAwesomeIcons.whatsapp,
        'Contáctate con nostros con un toque',
        Colors.green.shade700,
        Colors.green.shade400,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BotonLink(
                        texto: 'Guia de Seguridad',
                        color1: Color.fromARGB(255, 0, 167, 8),
                        color2: Color.fromARGB(255, 62, 252, 14),
                        onPress: () {}),
                    BotonLink(
                        texto: 'Plan de contingencia',
                        color1: Color.fromARGB(255, 62, 252, 14),
                        color2: Color.fromARGB(255, 0, 158, 61),
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const FormularioEmergencia()));
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BotonLink(
                        texto: 'Blog de articulos',
                        color1: Color.fromARGB(255, 0, 158, 61),
                        color2: Color.fromARGB(255, 62, 252, 14),
                        onPress: () {}),
                    BotonLink(
                        texto: 'Numero de emergencias',
                        color1: Color.fromARGB(255, 62, 252, 14),
                        color2: Color.fromARGB(255, 0, 158, 61),
                        onPress: () {}),
                  ],
                ),
                SizedBox(
                  height: responsive.hp(8),
                ),
                const Center(child: Text("Emergencias Gobernación: 800148139")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: responsive.hp(20),
                        child: Icon(
                            IconData(0xe198, fontFamily: 'MaterialIcons'))),
                    Text("Solution "),
                    FaIcon(FontAwesomeIcons.heart)
                  ],
                ),
              ],
            ),
          ),
          Encabezado(),
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
