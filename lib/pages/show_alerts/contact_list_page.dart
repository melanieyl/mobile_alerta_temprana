import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';
import 'package:mobile_alerta_temprana/pages/sendNotification/form_page.dart';
import 'package:mobile_alerta_temprana/pages/show_alerts/alert.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:mobile_alerta_temprana/widgets/cards.dart';
import 'package:mobile_alerta_temprana/widgets/perspective_list_view.dart';

class MicrosListPage extends StatefulWidget {
  const MicrosListPage({required this.nombreEvento, super.key});
  final String nombreEvento;
  @override
  MicrosListPageState createState() => MicrosListPageState();
}

class MicrosListPageState extends State<MicrosListPage> {
  final _searchController = TextEditingController();
  _opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Column(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1,
                    color: Colors.blueGrey,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                      'Municipios',
                      style: TextStyle(fontSize: 16),
                    )),
                  ]),
                ),
              )
            ]),
          );
        });
  }

  @override
  void initState() {
    // _loadData();
    print(alertas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 155, 240, 58), Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Stack(children: [
            PerspectiveListView(
              visualizedItems: alertas.length,
              itemExtent: responsive.hp(50),
              initialIndex: alertas.length - 1,
              enableBackItemsShadow: true,
              backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(13),
              onTapFrontItem: (index) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Alertas(
                              alert: alertas[index!],
                            )));
                // final color = Colors.accents[index! % Colors.accents.length];
                // Navigator.push(
                //   context,
                //   MaterialPageRoute<dynamic>(
                //     builder: (_) => ContactDetailScreen(
                //       color: color,
                //       distance: 4,
                //     ),
                //   ),
                // );
              },
              children: List.generate(alertas.length, (index) {
                return MicrosCard(
                  alert: alertas[index],
                );
              }),
            ),
            Container(
              //padding: EdgeInsets.only(top: 20),
              height: responsive.hp(10),
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: responsive.wp(70),
                    child: Expanded(
                      child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            //suffixIcon: Icon(Icons.clear),
                            hintText: "Buscar",
                            prefixIcon: Icon(Icons.search),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _opciones(context);
                      },
                      icon: Icon(
                        Icons.format_list_numbered_rounded,
                        size: 33,
                        color: Colors.black54,
                      )),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025),
                      );
                      // Hacer algo con la fecha seleccionada
                    },
                  ),
                ],
              ),
            )
          ]),
          //---------------------------------------
          // Drawer
          //---------------------------------------
        ),
      ),
    );
  }
}
