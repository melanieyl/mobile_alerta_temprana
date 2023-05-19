import 'package:flutter/material.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

class Mensajewhatsap extends StatefulWidget {
  const Mensajewhatsap({super.key});

  @override
  State<Mensajewhatsap> createState() => _MensajewhatsapState();
}

class _MensajewhatsapState extends State<Mensajewhatsap> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+001-(555)1234567',
      text: "Hey! I'm inquiring about the apartment listing",
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        child: Text('dale click'),
        onPressed: () {
          // FlutterOpenWhatsapp.sendSingleMessage("918179015345", "Hello");
        });
  }
}
