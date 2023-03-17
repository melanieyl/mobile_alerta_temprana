import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Alert.dart';
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
  @override
  void initState() {
    // _loadData();
    print(alertas);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 165, 18, 18),
            Colors.green,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: PerspectiveListView(
        visualizedItems: alertas.length,
        itemExtent: responsive.hp(70),
        initialIndex: alertas.length - 1,
        enableBackItemsShadow: true,
        backItemsShadowColor: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10),
        onTapFrontItem: (index) {},
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
