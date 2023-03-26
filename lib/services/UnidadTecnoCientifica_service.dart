import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/UnidadTecnoCientifica.dart';

class UnidadTecnoCientificaServices with ChangeNotifier {
  static Future<List<UnidadTecnoCientificaResponse>>
      getUnidadTecnoCientifica() async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/events');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final respuesta = jsonDecode(resp.body);
      final List<UnidadTecnoCientificaResponse> listUnidadTecnoCientifica =
          unidadTecnoCientificaResponseFromJson(jsonEncode(respuesta));
      //listUnidadTecnoCientifica.((element) {});
      return listUnidadTecnoCientifica;
    } catch (e) {
      print('mi errorosndu:' + e.toString());
      return [];
    }
  }
}
