// import 'dart:convert';
// import 'package:alerta_temprana_scz/models/Alert.dart';
// import 'package:http/http.dart' as http;

// class AlertasServices {
//   Future getAlerts(String nombre) async {
//     try {
//       final uri = Uri.parse('http://10.0.2.2:8000/api/alerts/getAlerts/');
//       final resp = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: {'nombre': nombre},
//       );

//       final alertaResponse = alertaResponseFromJson(resp.body);
//       return alertaResponse.data;
//     } catch (e) {
//       print(e);
//       return e;
//     }
//   }
// }
