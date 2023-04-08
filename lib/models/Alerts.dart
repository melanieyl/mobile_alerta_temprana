// To parse this JSON data, do
//
//     final alertResponse = alertResponseFromJson(jsonString);

import 'dart:convert';

List<AlertResponse> alertResponseFromJson(String str) =>
    List<AlertResponse>.from(
        json.decode(str).map((x) => AlertResponse.fromJson(x)));

String alertResponseToJson(List<AlertResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertResponse {
  AlertResponse({
    required this.id,
    required this.nombre,
    required this.fecha,
    required this.hora,
    required this.description,
    required this.geoX,
    required this.geoY,
    required this.urlMapa,
    required this.eventoId,
    required this.nombreUnidadTecnocientifica,
    required this.telefono,
  });

  int id;
  String nombre;
  DateTime fecha;
  String hora;
  String description;
  int geoX;
  int geoY;
  String urlMapa;
  int eventoId;
  String nombreUnidadTecnocientifica;
  String telefono;

  factory AlertResponse.fromJson(Map<String, dynamic> json) => AlertResponse(
        id: json["id"],
        nombre: json["nombre"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        description: json["description"],
        geoX: json["geoX"],
        geoY: json["geoY"],
        urlMapa: json["url_mapa"],
        eventoId: json["evento_id"],
        nombreUnidadTecnocientifica: json["nombreUnidadTecnocientifica"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "description": description,
        "geoX": geoX,
        "geoY": geoY,
        "url_mapa": urlMapa,
        "evento_id": eventoId,
        "nombreUnidadTecnocientifica": nombreUnidadTecnocientifica,
        "telefono": telefono,
      };
}
