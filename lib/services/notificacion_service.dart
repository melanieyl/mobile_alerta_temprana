import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_alerta_temprana/global/enviroment.dart';
import 'package:mobile_alerta_temprana/models/Alerts.dart';

class AlertasServices with ChangeNotifier {
  Future<List<AlertResponse>> getAlerts(int id) async {
    try {
      final uri = Uri.parse('${Environment.apiUrl}/alertsUnidadTecnica/$id');
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

class NotificationService with ChangeNotifier {
  //  Future<String> uploadImage(String image) async {
  //   try {
  //     final uri = Uri.parse('${Environment.apiUrl}/api-save-image');
  //     final resp = await http.get(uri, headers: {
  //       'Content-Type': 'multipart/form-data',
  //            });
  //     // final respuesta = jsonDecode(resp.body);
  //     final String  listAlerts =
  //         alertResponseFromJson();

  //     return listAlerts;
  //   } catch (e) {
  //     print('no me da nada');
  //     return [];
  //   }
  // }
  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse('${Environment.apiUrl}/api-save-image');
    final request = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(file);
    final response = await request.send();
    if (response.statusCode == 200) {
      print('La imagen se ha subido exitosamente');
    } else {
      print('Error al subir la imagen: ${response.statusCode}');
    }
  }
}
