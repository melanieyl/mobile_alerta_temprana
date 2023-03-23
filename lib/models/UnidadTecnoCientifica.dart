// To parse this JSON data, do
//
//     final unidadTecnoCientificaResponse = unidadTecnoCientificaResponseFromJson(jsonString);

import 'dart:convert';

List<UnidadTecnoCientificaResponse> unidadTecnoCientificaResponseFromJson(
        String str) =>
    List<UnidadTecnoCientificaResponse>.from(
        json.decode(str).map((x) => UnidadTecnoCientificaResponse.fromJson(x)));

String unidadTecnoCientificaResponseToJson(
        List<UnidadTecnoCientificaResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnidadTecnoCientificaResponse {
  UnidadTecnoCientificaResponse({
    required this.id,
    required this.nombre,
    required this.sigla,
  });

  int id;
  String nombre;
  String sigla;

  factory UnidadTecnoCientificaResponse.fromJson(Map<String, dynamic> json) =>
      UnidadTecnoCientificaResponse(
        id: json["id"],
        nombre: json["nombre"],
        sigla: json["sigla"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "sigla": sigla,
      };
}
