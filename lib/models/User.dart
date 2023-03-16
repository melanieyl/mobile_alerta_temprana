

// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        required this.mensaje,
        required this.data,
    });

    String mensaje;
    Data data;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        mensaje: json["mensaje"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.email,
        required this.telefono,
        required this.profilePhotoUrl,
    });

    int id;
    String name;
    String email;
    String telefono;
    String profilePhotoUrl;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        telefono: json["telefono"],
        profilePhotoUrl: json["profile_photo_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "telefono": telefono,
        "profile_photo_url": profilePhotoUrl,
    };
}
