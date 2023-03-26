import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/models/Estado.dart';
import 'package:mobile_alerta_temprana/global/enviroment.dart';

class EstadosServices with ChangeNotifier {
  static Future<List<EstadoResponse>> getEstados() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/estado');

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
