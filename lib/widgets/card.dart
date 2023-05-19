import 'package:flutter/material.dart';

class Cardenvio extends StatelessWidget {
  final String titulo;
  final double sizetext;

  const Cardenvio({super.key, required this.titulo, required this.sizetext});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              titulo,
              style: TextStyle(fontSize: sizetext),
            ),
          ),
        ));
  }
}
