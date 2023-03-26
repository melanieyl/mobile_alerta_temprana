import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';

class AlertasServices with ChangeNotifier {
  static Future<List<AlertResponse>> getAlerts() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/alerts');
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
      print('no me da nada');
      return [];
    }
  }
}
