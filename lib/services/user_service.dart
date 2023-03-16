import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> notification(
    int id,
    int idUsuario,
    String descripcion,
    int idEvento,
    List fotos,
    String videos,
    double longitud,
    double latitud) async {
  try {
    final response = await http.post(
      Uri.parse('https://tu-api.com/api/login'),
      body: {
        'idUsuario': idUsuario,
        'descripcion': descripcion,
        'idEvento': idEvento,
        'fotos': fotos,
        'videos': videos,
        'longitud': longitud,
        'latitud': latitud
      },
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'data': responseData['data'],
      };
    } else {
      return {
        'success': false,
        'message': responseData['mensaje'],
      };
    }
  } catch (error) {
    return {
      'success': false,
      'message': 'Ha ocurrido un error al realizar la solicitud.',
    };
  }
}
