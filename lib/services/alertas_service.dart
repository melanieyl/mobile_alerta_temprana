import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';

class AlertasServices with ChangeNotifier {
  Future<List<AlertResponse>> getAlerts(int id) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/alertas/$id');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      print("continua");

      final respuesta = jsonDecode(resp.body);
      print("la respuesta ");
      final List<AlertResponse> listAlerts =
          alertResponseFromJson(jsonEncode(respuesta));
      listAlerts.forEach((element) {});
      return listAlerts;
    } catch (e) {
      print('no me da nada');
      return [];
    }
  }
}
