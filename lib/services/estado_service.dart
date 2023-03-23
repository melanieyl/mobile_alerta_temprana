import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/models/Estado.dart';

class EstadosServices with ChangeNotifier {
  static Future<List<EstadoResponse>> getEstados() async {
    try {
      final uri = Uri.parse(
          'http://192.168.132.241/alerta-temprana-scz/public/api/events');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final respuesta = jsonDecode(resp.body);
      final List<EstadoResponse> listEstados =
          estadoResponseFromJson(jsonEncode(respuesta));
      listEstados.forEach((element) {});
      return listEstados;
    } catch (e) {
      print('mi errorosndu:' + e.toString());
      return [];
    }
  }
}
