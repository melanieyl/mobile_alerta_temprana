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
  int id;
  String nombre;
  dynamic fecha;
  dynamic hora;
  String description;
  int geoX;
  int geoY;
  String urlMapa;
  int eventoId;
  int unidadId;
  DateTime createdAt;
  DateTime updatedAt;

  AlertResponse({
    required this.id,
    required this.nombre,
    this.fecha,
    this.hora,
    required this.description,
    required this.geoX,
    required this.geoY,
    required this.urlMapa,
    required this.eventoId,
    required this.unidadId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AlertResponse.fromJson(Map<String, dynamic> json) => AlertResponse(
        id: json["id"],
        nombre: json["nombre"],
        fecha: json["fecha"],
        hora: json["hora"],
        description: json["description"],
        geoX: json["geoX"],
        geoY: json["geoY"],
        urlMapa: json["url_mapa"],
        eventoId: json["evento_id"],
        unidadId: json["unidad_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "fecha": fecha,
        "hora": hora,
        "description": description,
        "geoX": geoX,
        "geoY": geoY,
        "url_mapa": urlMapa,
        "evento_id": eventoId,
        "unidad_id": unidadId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
