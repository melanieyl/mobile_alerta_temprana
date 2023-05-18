// To parse this JSON data, do
//
//     final estadoResponse = estadoResponseFromJson(jsonString);

import 'dart:convert';

List<EstadoResponse> estadoResponseFromJson(String str) =>
    List<EstadoResponse>.from(
        json.decode(str).map((x) => EstadoResponse.fromJson(x)));

String estadoResponseToJson(List<EstadoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstadoResponse {
  int id;
  String nombre;
  String color;

  EstadoResponse({
    required this.id,
    required this.nombre,
    required this.color,
  });
  factory EstadoResponse.fromJson(Map<String, dynamic> json) => EstadoResponse(
        id: json["id"],
        nombre: json["nombre"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "color": color,
      };
}
