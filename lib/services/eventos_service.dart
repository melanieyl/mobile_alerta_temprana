import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';

class EventosServices with ChangeNotifier {
  static Future<List<EventoResponse>> getEventos() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/events');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final respuesta = jsonDecode(resp.body);
      final List<EventoResponse> listEventos =
          eventoResponseFromJson(jsonEncode(respuesta));
      listEventos.forEach((element) {});
      return listEventos;
    } catch (e) {
      print('mi errorosndu:' + e.toString());
      return [];
    }
  }
}
