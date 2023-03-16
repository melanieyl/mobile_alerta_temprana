import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/home.dart';

crearNotificaciones(
    int idUsuario,
    String descripcion,
    List<String> foto,
    String video,
    String fecha,
    int idEvento,
    double latitud,
    double longitud,
    BuildContext context) async {
  final uri = Uri.parse('http://10.0.2.2:8000/api/crear');
  final resp = await http.post(
    uri,
    body: jsonEncode({
      'descripcion': descripcion,
      'foto': foto,
      'video': video,
      'fecha': fecha,
      'ubicacion_long': longitud,
      'ubicacion_lat': latitud,
      'idevento': idEvento,
      'idusuario': idUsuario,
    }),
    headers: {'Content-Type': 'application/json'},
  );
  // final respuesta = jsonDecode(resp.body);
  // print(respuesta);
  Navigator.pop(context);
  if (200 == resp.statusCode) {
    // serverProvider.token = respuesta['token'];
    // Provider.of<ConsultaProvider>(context, listen: false).consultas = null;
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                HomePage(),
            transitionDuration: Duration(milliseconds: 0)));
  }
  // else {
  //   const mensajeErroneo = "Surgió un error";
  //   //mostrarAlerta(context, 'Error', mensajeErroneo);
  // }
}
