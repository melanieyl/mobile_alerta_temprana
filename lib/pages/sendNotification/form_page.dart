import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/services/eventos_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class FormularioEmergencia extends StatefulWidget {
  const FormularioEmergencia({super.key});

  @override
  State<FormularioEmergencia> createState() => _FormularioEmergenciaState();
}

class _FormularioEmergenciaState extends State<FormularioEmergencia> {
  final _textControllerdescripcion = TextEditingController();
  final _nombreyapellido = TextEditingController();
  final _telefono = TextEditingController();
  bool _veifyVideo = false;
  bool _miubicacion = false;
  late final double latitud;
  late final double longitud;
  final List<XFile?> _imageList = [];
  final List<String> _imageListP = [];

  final int _maxImageCount = 5;
  bool isVerifying = false;
  DateTime _creationDateTime = DateTime.now();
  String? eventoId;

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
  // final ImageSource traergalleria = ImageSource.gallery;

  _selectVideo(ImageSource formato) async {
    final XFile? video = await _video.pickVideo(source: formato);
    if (video != null) {
      final File direccionvideo = File(video.path);
      _veifyVideo = true;
      setState(() {});
    } else {}
  }

  _selectImage(ImageSource formato) async {
    if (_imageList.length < _maxImageCount) {
      XFile? picker = await ImagePicker().pickImage(source: formato);
      if (picker != null) {
        setState(() {
          _imageList.add(picker);
          _imageListP.add(picker.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //cabecera o slogan
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  //la fecha actual
                  Container(
                    width: responsive.width,
                    height: responsive.hp(8),
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
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 20),
                      ),
                    ),
                  ),
                  //nombre y apellido
                  SizedBox(
                    height: responsive.hp(2),
                  ),

                  TextField(
                      style:
                          TextStyle(color: Colors.cyan.shade900, fontSize: 18),
                      controller: _nombreyapellido,
                      decoration: _decoration('Nombre y Apellido')),
                  (isVerifying && _nombreyapellido.text.isEmpty)
                      ? const Text(
                          "Complete el campo Nombre y Apellido",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : SizedBox.shrink(),

                  //telefono///////////////////////////////////
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.cyan.shade900, fontSize: 18),
                    controller: _telefono,
                    decoration: _decoration("Numero de Telefono"),
                  ),
                  (isVerifying && _telefono.text.isEmpty)
                      ? const Text(
                          "Complete el campo telefono",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : SizedBox.shrink(),
                  //La descripcion////////////////////////////////////////////
                  SizedBox(
                    height: responsive.hp(2),
                  ),

                  TextField(
                      maxLines: 3,
                      style:
                          TextStyle(color: Colors.cyan.shade900, fontSize: 18),
                      controller: _textControllerdescripcion,
                      decoration: _decoration('Breve descripcion del Evento')),
                  (isVerifying && _textControllerdescripcion.text.isEmpty)
                      ? const Text(
                          "Complete el campo descripcion",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  //el evento//////////////////

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white, //<-- SEE HERE
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: eventos.isNotEmpty
                        ? DropdownButton(
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 20),
                            hint: const Text(
                              "seleccione un evento",
                              style: TextStyle(color: Colors.grey),
                            ),
                            value: eventoId,
                            items: eventos.map((e) {
                              return DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text(e.tipoEvento));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                eventoId = newValue.toString();
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
                  (isVerifying && (eventoId == null))
                      ? const Text(
                          "Elija un evento ",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : const SizedBox.shrink(),

                  //boton de guardar ubicacion////////////////////////////
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
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.add, color: Colors.red),
                          SizedBox(
                            width: responsive.wp(2),
                          ),
                          const Text('Guardar mi actual Ubicacion',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      )),
                  (isVerifying && _miubicacion == false)
                      ? const Text(
                          "haga click en el boton guardar ubicacion",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : SizedBox.shrink(),
                  //boton para guardar un video
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
                      onPressed: () {
                        _opciones(context, true);
                      },
                      child: Row(
                        children: <Widget>[
                          (_veifyVideo != false)
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.add, color: Colors.red),
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            'Subir un Video',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),

                  //botton para agregar imagenes
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
                    onPressed: () {
                      _opciones(context, false);
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
                      Text(
                        '${_imageList.length} / $_maxImageCount ',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: unnecessary_null_comparison
                  if (_imageList.length == null)
                    const SizedBox.shrink()
                  else
                    SizedBox(
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
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () async {
                        if (_textControllerdescripcion.text.isEmpty ||
                            _nombreyapellido.text.isEmpty ||
                            _telefono.text.isEmpty ||
                            (_creationDateTime == null) ||
                            !_miubicacion ||
                            (eventoId == null)) {
                          isVerifying = true;
                          Timer(Duration(seconds: 5), () {
                            // <-- Delay here
                            setState(() {
                              isVerifying = false; // <-- Code run after delay
                            });
                          });
                          setState(() {});
                          return;
                        }
                        Navigator.pop(context);
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration(String texto) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: texto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          _telefono.clear();
        },
        icon: Icon(Icons.clear),
      ),
    );
  }

  _opciones(context, bool dispositivo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final Responsive responsive = Responsive.of(context);
          return AlertDialog(
            content: SizedBox(
              height: responsive.hp(25),
              child: Column(children: [
                InkWell(
                  onTap: () {
                    if (dispositivo == true) {
                      _selectVideo(ImageSource.camera);
                    } else {
                      _selectImage(ImageSource.camera);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.blueGrey,
                    ))),
                    child: Row(children: const <Widget>[
                      Expanded(
                          child: Text(
                        'Camara',
                        style: TextStyle(fontSize: 16),
                      )),
                      Icon(Icons.camera)
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (dispositivo == true) {
                      _selectVideo(ImageSource.gallery);
                    } else {
                      _selectImage(ImageSource.gallery);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.blueGrey,
                    ))),
                    child: Row(children: const <Widget>[
                      Expanded(
                          child: Text(
                        'Galleria',
                        style: TextStyle(fontSize: 16),
                      )),
                      Icon(Icons.image)
                    ]),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // cierra el diálogo
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Colors.green, fontSize: responsive.hp(3)),
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
