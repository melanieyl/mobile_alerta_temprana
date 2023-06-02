import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/pages/show_alerts/contact_list_page.dart';
import 'package:mobile_alerta_temprana/services/eventos_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<EventoResponse> eventos = [];
  late Future<List<EventoResponse>> _eventosFuture;

  @override
  void initState() {
    _eventosFuture = EventosServices.getEventos();
    _eventosFuture.then((listEventos) {
      if (!mounted) return; // Verificar si el widget todavía está montado
      setState(() {
        eventos = listEventos;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _eventosFuture?.then((_) {}); // Esperar a que el futuro se complete
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 5,
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          children: [
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 50,
                      ),
                      itemCount: eventos.length,
                      itemBuilder: (context, index2) {
                        return Column(
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MicrosListPage(
                                              evento: eventos[index2],
                                            )));
                              },
                              child: Container(
                                  height: responsive.hp(15),
                                  width: responsive.wp(40),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: FadeInImage(
                                    image: NetworkImage(eventos[index2].foto),
                                    placeholder:
                                        const AssetImage('imgs/loading.gif'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(
                              height: responsive.hp(2.5),
                            ),
                            Text(
                              eventos[index2].tipoEvento,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            // Positioned(
            //   child: Container(
            //     width: responsive.width,
            //     height: responsive.hp(13),
            //     color: Colors.white,
            //     child: Image.asset(
            //       'imgs/sloganSCZ.png',
            //       scale: responsive.dp(2),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
