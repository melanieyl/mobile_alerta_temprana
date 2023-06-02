import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/helpers/progress_indicator_fachero.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/pages/show_alerts/alert.dart';
import 'package:mobile_alerta_temprana/services/alertas_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:mobile_alerta_temprana/widgets/cards.dart';
import 'package:mobile_alerta_temprana/widgets/perspective_list_view.dart';

class MicrosListPage extends StatefulWidget {
  const MicrosListPage({required this.evento, super.key});

  final EventoResponse evento;
  @override
  State<MicrosListPage> createState() => MicrosListPageState();
}

class MicrosListPageState extends State<MicrosListPage> {
  List<AlertResponse> alerts = [];

  @override
  void initState() {
    super.initState();
    AlertasServices().getAlerts(widget.evento.id).then((listAlerts) => {
          setState(() {
            alerts = listAlerts;
          }),
        });
    print('a qui estoy imprimiendo las lsita ' + '$alerts');
  }

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
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    width: 1,
                    color: Colors.blueGrey,
                  ))),
                  child: Row(children: const <Widget>[
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
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.evento.tipoEvento,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
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
            alerts.isNotEmpty
                ? PerspectiveListView(
                    visualizedItems: alerts.length,
                    itemExtent: responsive.hp(47),
                    initialIndex: alerts.length - 1,
                    enableBackItemsShadow: true,
                    backItemsShadowColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.all(13),
                    onTapFrontItem: (index) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Alertas(
                                    alert: alerts[index!],
                                  )));
                    },
                    children: List.generate(alerts.length, (index) {
                      return MicroCard(
                        alert: alerts[index],
                        colorestado: Colors.green.shade800,
                      );
                      // return Text('number' +
                      //     '$index' +
                      //     alerts[index].description.toString());
                    }),
                  )
                : CargandoSquare(),
            Container(
              //padding: EdgeInsets.only(top: 20),
              height: responsive.hp(10),
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: responsive.hp(6),
                      child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            //suffixIcon: Icon(Icons.clear),
                            hintText: 'buscar',
                            prefixIcon: const Icon(Icons.search),
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
