import 'package:flutter/material.dart';

class Estado {
  int id;
  String nombre;
  Color rojo;
  Color naranja;
  Color amarillo;
  Color verde;
  int grado;

  Estado(
      {required this.id,
      required this.nombre,
      this.rojo = const Color(0xfff80000),
      this.naranja = const Color(0xffffa500),
      this.amarillo = const Color(0xffffff00),
      this.verde = const Color(0xff008000),
      required this.grado});
}

final estados = [
  Estado(id: 1, nombre: "Critico", grado: 1),
  Estado(id: 2, nombre: "Muy alto", grado: 1),
  Estado(id: 3, nombre: "Moderado", grado: 1),
  Estado(id: 4, nombre: "Bajo", grado: 1),
];
