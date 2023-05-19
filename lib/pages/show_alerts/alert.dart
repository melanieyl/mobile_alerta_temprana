import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/helpers/progress_indicator_fachero.dart';
import 'package:mobile_alerta_temprana/models/AlertaEnvio.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/models/ImagenAlerta.dart';
import 'package:mobile_alerta_temprana/services/alertaenvio_service.dart';
import 'package:mobile_alerta_temprana/services/imagen_alerta_service.dart';
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
  List<ImagenAlertResponse> imageneEnvio = [];
  final controller = PageController(initialPage: 0);
  int currentPage = 0;

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  bool _isContentVisible = false;

  @override
  void initState() {
    // ignore: unnecessary_null_comparison
    ImagenAlertService().getImagenAlert(widget.alert.id).then((listImagen) => {
          setState(() {
            imageneEnvio = listImagen;
          }),
        });

    AlertaEnvioServices()
        .getAlertaEnvio(widget.alert.id)
        .then((listAlertaEnvio) => {
              setState(() {
                alertEnvio = listAlertaEnvio;
              }),
            });

    super.initState();
  }

  final List<String> imageUrls = [];
  String networkingimagen = 'http://192.168.132.16/alerta-temprana-scz/public';

  imagenesEnvios() {
    for (var i = 0; i < imageneEnvio.length; i++) {
      networkingimagen = networkingimagen + imageneEnvio[i].path;
      imageUrls.add(networkingimagen);
    }
  }
  // List<String> imagenes(){

  //    return
  // }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      drawer: alertEnvio.isNotEmpty
          ? Drawer(
              width: responsive.wp(40),
              child: ListView(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isContentVisible = true;
                            });
                          },
                          icon: Icon(
                            CupertinoIcons.info_circle_fill,
                            size: responsive.wp(10),
                          ),
                        ),
                        Text('VER ALERTA'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isContentVisible = false;
                            });
                          },
                          icon: Icon(
                            Icons.graphic_eq_outlined,
                            size: responsive.wp(10),
                          ),
                        ),
                        Text('VER HISTORIAL'),
                      ],
                    ),
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
                        return Card(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (!_isContentVisible) {
                                    controller.animateToPage(index,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                    setState(() {
                                      _isContentVisible = false;
                                      currentPage = index;
                                      print('$index');
                                    });
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.exclamationmark_shield_fill,
                                  size: responsive.wp(10),
                                  color: myColor,
                                ),
                              ),
                              Text(alertaenvio.nombreEstado),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ))
          : const CargandoSquare(),
      // body: _isContentVisible ? _contentAlerta() : _contentAlertaEnvio(),
      body: Stack(
        children: [
          _isContentVisible ? _contentAlerta() : _contentAlertaEnvio(),
          Positioned(
            top: responsive.hp(6),
            left: responsive.wp(2),
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentAlerta() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          (widget.alert.fecha == null || widget.alert.hora == null)
              ? SizedBox.shrink()
              : Cardenvio(
                  titulo: 'Fecha: ' +
                      widget.alert.fecha.toString().substring(0, 10) +
                      '   ' +
                      'Hora: ' +
                      widget.alert.hora.toString().substring(0, 5),
                  sizetext: 15),
          Center(
            child: Carddiseno(
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.alert.nombre.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Carddiseno(
            const FadeInImage(
              image: NetworkImage(
                  'https://th.bing.com/th/id/R.7ff5f870425d3d7d0cf98228c726d359?rik=4kwZ5kHRmY9gmA&pid=ImgRaw&r=0.jpg'),
              placeholder: AssetImage('imgs/loading.gif'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text('DESCRIPCION '),
                    ),
                    Cardenvio(titulo: widget.alert.description, sizetext: 15),
                  ],
                ),
              )),
        ],
      ),
    ));
  }

  Widget _contentAlertaEnvio() {
    final List<String> imagenesamarillas = [
      'imgs/amarillo/amarillo.jpg',
    ];
    final List<String> imagenesrojas = [
      'imgs/rojo/1.jpg',
      'imgs/rojo/2.jpg',
      'imgs/rojo/3.jpg',
      'imgs/rojo/4.jpg',
      'imgs/rojo/5.jpg',
      'imgs/rojo/8.jpg',
      'imgs/rojo/9.jpg',
      'imgs/rojo/10.jpg',
    ];
    final List<String> imagenesverdes = [
      'imgs/verde/verda.jpg',
      'imgs/verde/verde2.jpg',
      'imgs/verde/verde3.jpg',
      'imgs/verde/verde4.jpg',
      'imgs/verde/verde5.jpg',
    ];
    final List<String> imagenesnaranja = [
      'imgs/naranaja/naranja.jpg',
    ];

    return SafeArea(
      child: alertEnvio.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      color: Colors.white,
                      Icons.circle,
                      size: 60,
                    ),
                    Flexible(
                      child: Carddiseno(
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            widget.alert.nombre.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: alertEnvio.length,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      AlertaEnvioResponse alertaenvio = alertEnvio[index];
                      Color myColor = hexToColor(alertaenvio.color);
                      return Container(
                        color: myColor,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Icon(
                                Icons.podcasts_outlined,
                                color: myColor,
                              ),
                              Carddiseno(
                                Column(
                                  children: <Widget>[
                                    const FadeInImage(
                                      image: NetworkImage(
                                          'https://th.bing.com/th/id/R.7ff5f870425d3d7d0cf98228c726d359?rik=4kwZ5kHRmY9gmA&pid=ImgRaw&r=0.jpg'),
                                      placeholder:
                                          AssetImage('imgs/loading.gif'),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(alertaenvio.fecha
                                              .toString()
                                              .substring(0, 11) +
                                          alertaenvio.hora.substring(0, 5)),
                                    ),
                                  ],
                                ),
                              ),
                              Carddiseno(
                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('DESCRIPCION '),
                                    ),
                                    Cardenvio(
                                        titulo: alertaenvio.description,
                                        sizetext: 15),
                                  ],
                                ),
                              ),
                              Carddiseno(
                                Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text('RECOMENDACION'),
                                    ),
                                    Cardenvio(
                                        titulo: alertaenvio.recomendacion,
                                        sizetext: 15),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white60, // background
                                  // foreground
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Descargar Boletin',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white60, // background
                                  // foreground
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Ver Mapa',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              (alertaenvio.nombreEstado == 'Crítico')
                                  ? imagenes(imagenesrojas)
                                  : SizedBox.shrink(),
                              (alertaenvio.nombreEstado == 'Muy alto')
                                  ? imagenes(imagenesnaranja)
                                  : SizedBox.shrink(),
                              (alertaenvio.nombreEstado == 'Moderado')
                                  ? imagenes(imagenesamarillas)
                                  : SizedBox.shrink(),
                              (alertaenvio.nombreEstado == 'Bajo')
                                  ? imagenes(imagenesverdes)
                                  : SizedBox.shrink(),
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
    );
  }

  Card Carddiseno(Widget hijo) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        child: ClipRRect(borderRadius: BorderRadius.circular(30), child: hijo));
  }

  Card imagenes(List<String> imagenespath) {
    return Card(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: PageView.builder(
          itemCount: imagenespath.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                imagenespath[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
