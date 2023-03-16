// import 'package:alerta_temprana_scz/models/Alert.dart';
// import 'package:alerta_temprana_scz/models/Evento.dart';
// import 'package:alerta_temprana_scz/pages/show_alerts/implementation_cards/ui/contact_detail_screen.dart';
// import 'package:alerta_temprana_scz/pages/show_alerts/implementation_cards/ui/widgets/cards.dart';
// import 'package:alerta_temprana_scz/pages/show_alerts/implementation_cards/ui/widgets/perspective_list_view.dart';
// import 'package:alerta_temprana_scz/home.dart';
// import 'package:alerta_temprana_scz/main.dart';
// import 'package:alerta_temprana_scz/services/alertas_service.dart';
import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';
import 'package:mobile_alerta_temprana/widgets/cards.dart';
import 'package:mobile_alerta_temprana/widgets/perspective_list_view.dart';

class MicrosListPage extends StatefulWidget {
  const MicrosListPage({required this.nombreEvento, super.key});
  final String nombreEvento;
  @override
  MicrosListPageState createState() => MicrosListPageState();
}

class MicrosListPageState extends State<MicrosListPage> {
  // final alertaService = AlertasServices();

  // void _loadData() async {
  //   // alertas = await AlertasServices().getAlerts(widget.nombreEvento);
  //   print(alertas);
  //   setState(() {});
  // }

  @override
  void initState() {
    // _loadData();
    print(alertas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.green,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: PerspectiveListView(
        visualizedItems: alertas.length,
        itemExtent: 470,
        initialIndex: alertas.length - 1,
        enableBackItemsShadow: true,
        backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10),
        onTapFrontItem: (index) {
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
      //---------------------------------------
      // Drawer
      //---------------------------------------
    );
  }
}
