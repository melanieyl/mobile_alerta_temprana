// To parse this JSON data, do
//
//     final eventoResponse = eventoResponseFromJson(jsonString);

import 'dart:convert';

List<EventoResponse> eventoResponseFromJson(String str) =>
    List<EventoResponse>.from(
        json.decode(str).map((x) => EventoResponse.fromJson(x)));

String eventoResponseToJson(List<EventoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventoResponse {
  EventoResponse({
    required this.id,
    required this.tipoEvento,
    required this.descripcionTipoEvento,
    required this.foto,
  });

  int id;
  String tipoEvento;
  String descripcionTipoEvento;
  String foto;

  factory EventoResponse.fromJson(Map<String, dynamic> json) => EventoResponse(
        id: json["id"],
        tipoEvento: json["tipoEvento"],
        descripcionTipoEvento: json["descripcionTipoEvento"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoEvento": tipoEvento,
        "descripcionTipoEvento": descripcionTipoEvento,
        "foto": foto,
      };
}
