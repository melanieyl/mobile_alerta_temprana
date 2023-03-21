import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/models/Alerts.dart';

class AlertasServices with ChangeNotifier {
  static Future<List<AlertResponse>> getAlerts() async {
    try {
      final uri =
          Uri.parse('http://10.0.2.2/alerta-temprana-scz/public/api/alerts');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      print("hfasjfkasd");

      final respuesta = jsonDecode(resp.body);
      final List<AlertResponse> listAlerts =
          alertResponseFromJson(jsonEncode(respuesta));
      listAlerts.forEach((element) {
        print(element.description);
      });
      return listAlerts;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
