// To parse this JSON data, do
//
//     final imagenAlertResponse = imagenAlertResponseFromJson(jsonString);

import 'dart:convert';

List<ImagenAlertResponse> imagenAlertResponseFromJson(String str) =>
    List<ImagenAlertResponse>.from(
        json.decode(str).map((x) => ImagenAlertResponse.fromJson(x)));

String imagenAlertResponseToJson(List<ImagenAlertResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImagenAlertResponse {
  int id;
  String path;
  String description;
  int alertaEnvioId;
  dynamic createdAt;
  dynamic updatedAt;

  ImagenAlertResponse({
    required this.id,
    required this.path,
    required this.description,
    required this.alertaEnvioId,
    this.createdAt,
    this.updatedAt,
  });

  factory ImagenAlertResponse.fromJson(Map<String, dynamic> json) =>
      ImagenAlertResponse(
        id: json["id"],
        path: json["path"],
        description: json["description"],
        alertaEnvioId: json["alerta_envio_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "description": description,
        "alerta_envio_id": alertaEnvioId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
