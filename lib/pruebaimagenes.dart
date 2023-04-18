import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/services/eventos_service.dart';
import 'package:mobile_alerta_temprana/services/notificacion_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class FormularioEmergencia1 extends StatefulWidget {
  const FormularioEmergencia1({super.key});

  @override
  State<FormularioEmergencia1> createState() => _FormularioEmergencia1State();
}

class _FormularioEmergencia1State extends State<FormularioEmergencia1> {
  // _selectImage(ImageSource formato) async {
  //   if (_imageList.length < _maxImageCount) {
  //     XFile? picker = await ImagePicker().pickImage(source: formato);
  //     if (picker != null) {
  //       setState(() {
  //         _imageList.add(picker);
  //         _imageListP.add(picker.path);
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //cabecera o slogan

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: responsive.hp(7),
                    color: Colors.red,
                    hoverColor: Colors.cyan.shade900,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () async {
                      XFile? picker = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      NotificationService()
                          .uploadImage(picker)
                          .then((value) => null);
                    },
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: responsive.wp(15),
                      ),
                      const Text('Agregar imágenes',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: responsive.wp(5),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: responsive.hp(8),
                      color: Colors.black,
                      hoverColor: Colors.cyan.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Enviar",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () async {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
