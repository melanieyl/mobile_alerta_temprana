import 'package:mobile_alerta_temprana/models/Estado.dart';
import 'package:mobile_alerta_temprana/models/Evento.dart';
import 'package:mobile_alerta_temprana/models/Foto.dart';

class Alert {
  int id;
  String nombre;
  Evento tipo;
  String detalle;
  List<FotoIncidente> fotos;
  String video;
  Estado estado;
  DateTime fecha;
  Alert(
      {required this.id,
      required this.nombre,
      required this.detalle,
      required this.fotos,
      this.video = "",
      required this.estado,
      required this.fecha,
      required this.tipo});
}

final alertas = [
  Alert(
    id: 1,
    nombre: "Incendio Estructural de gran magnitud en surtidor Moragrande II",
    tipo: eventos[1],
    detalle:
        "Gran incendio estructural causado por imprudencia de los trabajadores del surtidor Moragrande II, donde hay 3 personas heridas con quemaduras de 1er. y 2do. grado",
    fotos: fotos_incendios_estructurales,
    estado: estados[1],
    fecha: DateTime.now(),
  ),
  Alert(
    id: 2,
    nombre: "Incendio forestal leve en la zona sur de la Chiquitanía",
    tipo: eventos[0],
    detalle:
        "Incendio forestal de baja intensidad en la parte baja de la Chiquitanía a causa de chaqueadores mal intencionados, que se prevee que fue intencionado",
    fotos: fotos_incendios_forestales,
    estado: estados[3],
    fecha: DateTime(2022, 9, 7, 17, 30),
  ),
  Alert(
    id: 3,
    nombre: "Alerta de posible inundación del río Piraí en las próximas horas",
    tipo: eventos[2],
    detalle:
        "Prevención de inundación en el río Piraí, en horas de la tarde, llegando la lluvia de la zona sur.",
    fotos: fotos_inundaciones,
    estado: estados[2],
    fecha: DateTime(2023, 9, 7, 17, 30),
  ),
  Alert(
    id: 4,
    nombre: "Conflicto social grave entre gente afines al Más",
    tipo: eventos[8],
    detalle:
        "Una pelea campal entre personas que son afines al partido del Más, está dejando muchas personas heridas, la cual solo ha incrementado la gravedad las últimas horas.",
    fotos: fotos_inundaciones,
    estado: estados[0],
    fecha: DateTime(2023, 03, 10, 13, 45),
  ),
];


// import 'package:alerta_temprana_scz/models/Estado.dart';
// import 'package:alerta_temprana_scz/models/Evento.dart';
// import 'package:alerta_temprana_scz/models/Foto.dart';

// class Alert {
//   int id;
//   String nombre;
//   Evento tipo;
//   String detalle;
//   List<FotoIncidente> fotos;
//   String video;
//   Estado estado;
//   DateTime fecha;
//   Alert(
//       {required this.id,
//       required this.nombre,
//       required this.detalle,
//       required this.fotos,
//       this.video = "",
//       required this.estado,
//       required this.fecha,
//       required this.tipo});
// }

// final alertas = [
//   Alert(
//     id: 1,
//     nombre: "Incendio Estructural de gran magnitud en surtidor Moragrande II",
//     tipo: eventos[1],
//     detalle:
//         "Gran incendio estructural causado por imprudencia de los trabajadores del surtidor Moragrande II, donde hay 3 personas heridas con quemaduras de 1er. y 2do. grado",
//     fotos: fotos_incendios_estructurales,
//     estado: estados[1],
//     fecha: DateTime.now(),
//   ),
//   Alert(
//     id: 2,
//     nombre: "Incendio forestal leve en la zona sur de la Chiquitanía",
//     tipo: eventos[0],
//     detalle:
//         "Incendio forestal de baja intensidad en la parte baja de la Chiquitanía a causa de chaqueadores mal intencionados, que se prevee que fue intencionado",
//     fotos: fotos_incendios_forestales,
//     estado: estados[3],
//     fecha: DateTime(2022, 9, 7, 17,30),
//   ),
//   Alert(
//     id: 3,
//     nombre: "Alerta de posible inundación del río Piraí en las próximas horas",
//     tipo: eventos[2],
//     detalle:
//         "Prevención de inundación en el río Piraí, en horas de la tarde, llegando la lluvia de la zona sur.",
//     fotos: fotos_inundaciones,
//     estado: estados[2],
//     fecha: DateTime(2023, 9, 7, 17,30),
//   ),
//   Alert(
//     id: 4,
//     nombre: "Conflicto social grave entre gente afines al Más",
//     tipo: eventos[8],
//     detalle:
//         "Una pelea campal entre personas que son afines al partido del Más, está dejando muchas personas heridas, la cual solo ha incrementado la gravedad las últimas horas.",
//     fotos: fotos_inundaciones,
//     estado: estados[0],
//     fecha: DateTime(2023, 03, 10, 13,45),
//   ),
// ];

// To parse this JSON data, do
//
//     final alertaResponse = alertaResponseFromJson(jsonString);

// import 'dart:convert';

// AlertaResponse alertaResponseFromJson(String str) =>
//     AlertaResponse.fromJson(json.decode(str));

// String alertaResponseToJson(AlertaResponse data) => json.encode(data.toJson());

// class AlertaResponse {
//   AlertaResponse({
//     required this.mensaje,
//     required this.data,
//   });

//   String mensaje;
//   List<Alert> data;

//   factory AlertaResponse.fromJson(Map<String, dynamic> json) => AlertaResponse(
//         mensaje: json["mensaje"],
//         data: List<Alert>.from(json["data"].map((x) => Alert.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "mensaje": mensaje,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Alert {
//   Alert({
//     required this.id,
//     required this.nombre,
//     required this.detalle,
//     required this.foto,
//     required this.video,
//     required this.ubicacionLong,
//     required this.ubicacionLat,
//     required this.fecha,
//     required this.hora,
//     required this.eventosNombre,
//     required this.estadosNombre,
//     required this.color,
//   });

//   int id;
//   String nombre;
//   String detalle;
//   String foto;
//   String video;
//   int ubicacionLong;
//   int ubicacionLat;
//   DateTime fecha;
//   String hora;
//   String eventosNombre;
//   String estadosNombre;
//   String color;

//   factory Alert.fromJson(Map<String, dynamic> json) => Alert(
//         id: json["id"],
//         nombre: json["nombre"],
//         detalle: json["detalle"],
//         foto: json["foto"],
//         video: json["video"],
//         ubicacionLong: json["ubicacion_long"],
//         ubicacionLat: json["ubicacion_lat"],
//         fecha: DateTime.parse(json["fecha"]),
//         hora: json["hora"],
//         eventosNombre: json["eventos_nombre"],
//         estadosNombre: json["estados_nombre"],
//         color: json["color"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "nombre": nombre,
//         "detalle": detalle,
//         "foto": foto,
//         "video": video,
//         "ubicacion_long": ubicacionLong,
//         "ubicacion_lat": ubicacionLat,
//         "fecha":
//             "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
//         "hora": hora,
//         "eventos_nombre": eventosNombre,
//         "estados_nombre": estadosNombre,
//         "color": color,
//       };

//   final alertas = [];
// }

