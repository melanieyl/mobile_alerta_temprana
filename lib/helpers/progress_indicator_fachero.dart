import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Cargandocircle extends StatelessWidget {
  const Cargandocircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.lightGreen,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )),
      child: Center(
        child: SpinKitCircle(
          size: 140,
          color: Colors.green[900],
        ),
      ),
    );
  }
}

class CargandoSquare extends StatelessWidget {
  const CargandoSquare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.lightGreen,
          Colors.white,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )),
      child: const Center(
        child: SpinKitDancingSquare(
          size: 140,
          color: Colors.white,
        ),
      ),
    );
  }
}
