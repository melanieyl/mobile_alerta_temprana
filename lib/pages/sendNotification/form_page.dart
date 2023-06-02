import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_alerta_temprana/models/Eventos.dart';
import 'package:mobile_alerta_temprana/pages/sendNotification/map_view.dart';
import 'package:mobile_alerta_temprana/services/eventos_service.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';
import 'package:video_player/video_player.dart';

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
  final List<File?> _imageList = [];
  final List<String> _imageListP = [];

  final int _maxImageCount = 5;
  bool isVerifying = false;
  DateTime _creationDateTime = DateTime.now();
  String? eventoId;
  late VideoPlayerController _controller;

  List<EventoResponse> eventos = [];

  @override
  void initState() {
    EventosServices.getEventos().then((listEventos) => {
          setState(() {
            eventos = listEventos;
          }),
        });
    _controller = VideoPlayerController.network('');

    super.initState();
  }

//guardar la pocision
  Future<void> _guardarPocision() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _miubicacion = true;
    setState(() {});
    latitud = position.latitude;
    longitud = position.longitude;
  }

//guardar los videos
  late File video2;
  _selectVideo(ImageSource formato) async {
    XFile? video = await ImagePicker().pickVideo(source: formato);

    if (video != null) {
      _veifyVideo = true;
      video2 = File(video.path);
      final File direccionvideo = File(video.path);
      _controller = VideoPlayerController.file(direccionvideo)
        ..initialize().then((_) {
          Navigator.pop(context);
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
    } else {}
  }

  _deleteVideo() async {
    //  video2 = File(video2.path); //otro cambio
    final file = File(video2.path);
    await file.writeAsString('', flush: true);
    setState(() {
      _controller.pause();
      _veifyVideo = false;
    });
  }

//guardar las imagenes
  _selectImage(ImageSource formato) async {
    if (_imageList.length < _maxImageCount) {
      XFile? picker = await ImagePicker().pickImage(source: formato);
      if (picker != null) {
        final File imagen = File(picker.path);
        setState(() {
          _imageList.add(imagen);
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
                  SizedBox(height: responsive.hp(1)),
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
                    child: Center(
                      child: Text(
                        _creationDateTime.toString().substring(0, 19),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  //nombre y apellido
                  SizedBox(height: responsive.hp(2)),

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
                  SizedBox(height: responsive.hp(2)),
                  TextField(
                    style: TextStyle(color: Colors.cyan.shade900, fontSize: 18),
                    controller: _telefono,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: _decoration("Numero de Telefono"),
                  ),
                  (isVerifying && _telefono.text.isEmpty)
                      ? const Text(
                          "Complete el campo telefono",
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        )
                      : const SizedBox.shrink(),
                  //La descripcion////////////////////////////////////////////
                  SizedBox(height: responsive.hp(2)),

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
                      : const SizedBox.shrink(),
                  SizedBox(height: responsive.hp(2)),
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
                  //boton para guardar un video
                  SizedBox(height: responsive.hp(2)),
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
                  //mostar el video
                  if (_veifyVideo == false)
                    const SizedBox.shrink()
                  else
                    Column(
                      children: [
                        SizedBox(
                          height: responsive.hp(5),
                        ),
                        Center(
                          child: _controller.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                )
                              : Container(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _deleteVideo();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  //botton para agregar imagenes
                  SizedBox(height: responsive.hp(2)),
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
                      SizedBox(width: responsive.wp(5)),
                      Text(
                        '${_imageList.length} / $_maxImageCount ',
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 17,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  //mostrar imagenes
                  if (_imageList.isEmpty)
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
                            return (_imageListP.isNotEmpty &&
                                    _imageListP.length > index)
                                ? Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          File(_imageListP[index]),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _imageListP.removeAt(index);
                                              _imageList.removeAt(index);
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink();
                          },
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
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.add, color: Colors.red),
                          SizedBox(
                            width: responsive.wp(5),
                          ),
                          const Text('Seleccionar ubicacion',
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

                  (_miubicacion)
                      ? Map_View(latitud: latitud, longitud: longitud)
                      : SizedBox.shrink(),

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
                          Timer(const Duration(seconds: 5), () {
                            // <-- Delay here
                            setState(() {
                              isVerifying = false; // <-- Code run after delay
                            });
                          });
                          setState(() {});

                          return;
                        }
                        // if (_imageList.isNotEmpty) {
                        //   for (var i = 0; i < _imageList.length; i++) {
                        //     NotificationService()
                        //         .uploadImage(
                        //             _imageList[i]!) //le estoy añadiendo un !
                        //         .then((value) => null);
                        //   }
                        // }
                        // NotificationService()
                        //     .uploadImage(video2)
                        //     .then((value) => null);

                        // AlertDialog(
                        //   content: Text('imagenes subidas exitosamente' +
                        //       _imageListP.toString()),
                        // );

                        // Navigator.pop(context);
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
