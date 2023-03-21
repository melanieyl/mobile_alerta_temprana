import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/models/Alerts.dart';

class AlertasServices with ChangeNotifier {
  Future<List<AlertResponse>> getAlerts() async {
    try {
      final uri =
          Uri.parse('http://10.0.2.2/alerta-temprana-scz/public/api/alerts');
      final resp = await http.get(
        uri,
        
      );
      print("hfasjfkasd");

      final alertaResponse = alertResponseFromJson(resp.body);
      alertaResponse.forEach((element) {
        print(element);
      });
      return alertaResponse;
    } catch (e) {
      print("error");
      print(e);
      return [];
    }
  }
}
