import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/services/eventos_service.dart';
import 'package:mobile_alerta_temprana/services/notificaiones.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

import '../../helpers/progress_indicator_fachero.dart';

class FormularioEmergencia extends StatefulWidget {
  const FormularioEmergencia({super.key});

  @override
  State<FormularioEmergencia> createState() => _FormularioEmergenciaState();
}

class _FormularioEmergenciaState extends State<FormularioEmergencia> {
  final _textControllerdescripcion = TextEditingController();
  final _creationDateTimeController = TextEditingController();
  final _idUsuario = 1;
  bool _veifyVideo = false;
  bool _miubicacion = false;
  late final double latitud;
  late final double longitud;
  String? _video2;
  final List<XFile?> _imageList = [];
  final List<String> _imageListP = [];

  final int _maxImageCount = 5;
  bool isVerifying = false;

  List<EventoResponse> eventos = [];

  @override
  void initState() {
    EventosServices.getEventos().then((listEventos) => {
          setState(() {
            eventos = listEventos;
          }),
        });
    super.initState();
  }

  DateTime? _creationDateTime = DateTime.now();
  String? eventoId;

  void _selectDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        if (value != null) {
          _creationDateTime = value;
        }
        _creationDateTimeController.text = _creationDateTime.toString();
      });
    });
  }

  Future<void> _guardarPocision() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _miubicacion = true;
    setState(() {});

    latitud = position.latitude;
    longitud = position.longitude;
  }

  final ImagePicker _video = ImagePicker();

  Future<void> _selectVideo() async {
    final XFile? video = await _video.pickVideo(source: ImageSource.gallery);
    _video2 = video!.path;

    if (video != null) {
      final File image = File(video.path);
      _veifyVideo = true;
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: responsive.hp(3),
            ),
            Container(
              width: responsive.width,
              height: responsive.hp(15),
              color: Colors.white,
              child: Image.asset(
                'imgs/sloganSCZ.png',
                scale: responsive.dp(1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        TextField(
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.cyan.shade900, fontSize: 18),
                          controller: _textControllerdescripcion,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Breve descripcion del evento",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _textControllerdescripcion.clear();
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                        (isVerifying && _textControllerdescripcion.text.isEmpty)
                            ? const Text(
                                "Complete el campo descripcion",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Container(
                          width: responsive.width,
                          height: responsive.hp(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: responsive.hp(3), left: responsive.wp(2)),
                            child: Text(
                              _creationDateTime.toString().substring(0, 19),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white, //<-- SEE HERE
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: eventos.isNotEmpty
                              ? DropdownButton(
                                  style: TextStyle(
                                      color: Colors.cyan.shade900,
                                      fontSize: 20),
                                  hint: const Text(
                                    "seleccione un evento",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  value: eventoId,
                                  items: eventos.map((e) {
                                    print(e);
                                    return DropdownMenuItem(
                                        value: e.id.toString(),
                                        child: Text(e.tipoEvento));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      eventoId = newValue.toString();
                                      print(eventoId);
                                    });
                                  },
                                )
                              : Center(
                                  child: SpinKitCircle(
                                    size: responsive.dp(3),
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: responsive.hp(7),
                            color: Colors.green.shade800,
                            hoverColor: Colors.green.shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: _guardarPocision,
                            child: Row(
                              children: <Widget>[
                                (_miubicacion != false)
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : const Icon(Icons.add, color: Colors.red),
                                SizedBox(
                                  width: responsive.wp(2),
                                ),
                                const Text('Guardar mi actual Ubicacion',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ],
                            )),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            height: responsive.hp(7),
                            color: Colors.green.shade800,
                            hoverColor: Colors.greenAccent.shade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: _selectVideo,
                            child: Row(
                              children: <Widget>[
                                (_veifyVideo != false)
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : const Icon(Icons.add, color: Colors.red),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Text(
                                  'Subir un Video',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: responsive.hp(7),
                          color: Colors.lightGreen.shade500,
                          hoverColor: Colors.cyan.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () async {
                            if (_imageList.length < _maxImageCount) {
                              XFile? picker = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (picker != null) {
                                setState(() {
                                  _imageList.add(picker);
                                  _imageListP.add(picker.path);
                                });
                              }
                            } else {
                              print('lista de imagenes' +
                                  '$_imageList'); // Muestra un mensaje al usuario indicando que ya ha seleccionado el número máximo de imágenes
                            }
                          },
                          child: Row(children: <Widget>[
                            SizedBox(
                              width: responsive.wp(15),
                            ),
                            const Text('Agregar imágenes',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            SizedBox(
                              width: responsive.wp(5),
                            ),
                            Text(
                              '${_imageList.length} / $_maxImageCount ',
                              style: const TextStyle(
                                color: Colors.black38,
                                fontSize: 17,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // ignore: unnecessary_null_comparison
                        if (_imageList.length == null)
                          Center()
                        else
                          Container(
                            width: responsive.width,
                            height: responsive.hp(20),
                            child: Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _imageList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(File(_imageListP[index])),
                                  );
                                },
                              ),
                            ),
                          ),
                        SizedBox(
                          height: responsive.hp(4),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            onPressed: () {
                              // print(_idUsuario);
                              // print(_textControllerdescripcion.text);
                              // print(_imageListP);
                              // print(_creationDateTimeController.text);
                              // print(int.parse(eventoId!));
                              // print(latitud);
                              // print(longitud);
                              // crearNotificaciones(
                              //     _idUsuario,
                              //     _textControllerdescripcion.text,
                              //     _imageListP,
                              //     _video2!,
                              //     _creationDateTimeController.text,
                              //     int.parse(eventoId!),
                              //     latitud,
                              //     longitud,
                              //     context);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
