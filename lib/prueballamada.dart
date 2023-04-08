import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

// For Flutter applications, you'll most likely want to use
// the url_launcher package.
// import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class Whatssap extends StatelessWidget {
  Whatssap({super.key});
  final Uri _url = Uri.parse('https://flutter.dev');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    } else {}
  }

  void main() async {
    final link = WhatsAppUnilink(
        phoneNumber: '+1 234-567-8901', text: "¡Hola! ¿Cómo estás?");
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: main,
      child: Text('Show Flutter homepage'),
    );
  }
}
