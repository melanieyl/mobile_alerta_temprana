// To parse this JSON data, do
//
//     final alertaEnvioResponse = alertaEnvioResponseFromJson(jsonString);

import 'dart:convert';

List<AlertaEnvioResponse> alertaEnvioResponseFromJson(String str) =>
    List<AlertaEnvioResponse>.from(
        json.decode(str).map((x) => AlertaEnvioResponse.fromJson(x)));

String alertaEnvioResponseToJson(List<AlertaEnvioResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertaEnvioResponse {
  AlertaEnvioResponse({
    required this.alertaEnvioId,
    required this.alertaId,
    required this.fecha,
    required this.hora,
    required this.puntoX,
    required this.puntoY,
    required this.urlMapa,
    required this.description,
    required this.imgCabecera,
    required this.imgAlerta,
    required this.urlBoletin,
    required this.recomendacion,
    required this.color,
    required this.nombreEstado,
  });

  int alertaEnvioId;
  int alertaId;
  DateTime fecha;
  String hora;
  int puntoX;
  int puntoY;
  String urlMapa;
  String description;
  String imgCabecera;
  String imgAlerta;
  String urlBoletin;
  String recomendacion;
  String color;
  String nombreEstado;

  factory AlertaEnvioResponse.fromJson(Map<String, dynamic> json) =>
      AlertaEnvioResponse(
        alertaEnvioId: json["alerta_envio_id"],
        alertaId: json["alerta_id"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        puntoX: json["puntoX"],
        puntoY: json["puntoY"],
        urlMapa: json["url_mapa"],
        description: json["description"],
        imgCabecera: json["img_cabecera"],
        imgAlerta: json["img_alerta"],
        urlBoletin: json["url_boletin"],
        recomendacion: json["recomendacion"],
        color: json["color"],
        nombreEstado: json["nombre_estado"],
      );

  Map<String, dynamic> toJson() => {
        "alerta_envio_id": alertaEnvioId,
        "alerta_id": alertaId,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "puntoX": puntoX,
        "puntoY": puntoY,
        "url_mapa": urlMapa,
        "description": description,
        "img_cabecera": imgCabecera,
        "img_alerta": imgAlerta,
        "url_boletin": urlBoletin,
        "recomendacion": recomendacion,
        "color": color,
        "nombre_estado": nombreEstado,
      };
}

// // To parse this JSON data, do
// //
// //     final alertaEnvioResponse = alertaEnvioResponseFromJson(jsonString);

// import 'dart:convert';

// List<AlertaEnvioResponse> alertaEnvioResponseFromJson(String str) =>
//     List<AlertaEnvioResponse>.from(
//         json.decode(str).map((x) => AlertaEnvioResponse.fromJson(x)));

// String alertaEnvioResponseToJson(List<AlertaEnvioResponse> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class AlertaEnvioResponse {
//   AlertaEnvioResponse({
//     required this.id,
//     required this.alertaId,
//     required this.estadoId,
//     required this.fecha,
//     required this.hora,
//     required this.puntoX,
//     required this.puntoY,
//     required this.urlMapa,
//     required this.description,
//     required this.imgCabecera,
//     required this.imgAlerta,
//     required this.urlBoletin,
//     required this.recomendacion,
//   });

//   int id;
//   int alertaId;
//   int estadoId;
//   DateTime fecha;
//   String hora;
//   int puntoX;
//   int puntoY;
//   String urlMapa;
//   String description;
//   String imgCabecera;
//   String imgAlerta;
//   String urlBoletin;
//   String recomendacion;

//   factory AlertaEnvioResponse.fromJson(Map<String, dynamic> json) =>
//       AlertaEnvioResponse(
//         id: json["id"],
//         alertaId: json["alerta_id"],
//         estadoId: json["estado_id"],
//         fecha: DateTime.parse(json["fecha"]),
//         hora: json["hora"],
//         puntoX: json["puntoX"],
//         puntoY: json["puntoY"],
//         urlMapa: json["url_mapa"],
//         description: json["description"],
//         imgCabecera: json["img_cabecera"],
//         imgAlerta: json["img_alerta"],
//         urlBoletin: json["url_boletin"],
//         recomendacion: json["recomendacion"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "alerta_id": alertaId,
//         "estado_id": estadoId,
//         "fecha":
//             "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
//         "hora": hora,
//         "puntoX": puntoX,
//         "puntoY": puntoY,
//         "url_mapa": urlMapa,
//         "description": description,
//         "img_cabecera": imgCabecera,
//         "img_alerta": imgAlerta,
//         "url_boletin": urlBoletin,
//         "recomendacion": recomendacion,
//       };
// }
