import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/AlertaEnvio.dart';

class AlertaEnvioServices with ChangeNotifier {
  Future<List<AlertaEnvioResponse>> getAlertaEnvio(int id) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/getalerta/$id');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final respuesta = jsonDecode(resp.body);
      final List<AlertaEnvioResponse> listAlertaEnvio =
          alertaEnvioResponseFromJson(jsonEncode(respuesta));
      //listEventos.forEach((element) {});
      return listAlertaEnvio;
    } catch (e) {
      print('mi errorosndu:' + e.toString());
      return [];
    }
  }
}
