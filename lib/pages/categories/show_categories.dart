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

  // List<Event> eventosCategories = [];
  @override
  void initState() {
    EventosServices.getEventos().then((listEventos) => {
          setState(() {
            eventos = listEventos;
          }),
        });
    super.initState();
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

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MicrosListPage(
                                //             nombreEvento:
                                //                 eventos[index2].tipoEvento)));
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
      floatingActionButton: FloatingActionButton(
        heroTag: "MainButton",
        backgroundColor: Colors.green.shade900,
        child: Icon(Icons.call),
        onPressed: () {},
      ),
    );
  }
}
