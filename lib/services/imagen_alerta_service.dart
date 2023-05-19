import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/ImagenAlerta.dart';

class ImagenAlertService with ChangeNotifier {
  Future<List<ImagenAlertResponse>> getImagenAlert(int id) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/imagenalerta/$id');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      final respuesta = jsonDecode(resp.body);
      final List<ImagenAlertResponse> listImagen =
          imagenAlertResponseFromJson(jsonEncode(respuesta));
      listImagen.forEach((element) {});

      return listImagen;
    } catch (e) {
      print('mi error en imagenes :' + e.toString());
      return [];
    }
  }
}
