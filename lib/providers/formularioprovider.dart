import 'dart:io';

import 'package:flutter/material.dart';

class Formularioprovider with ChangeNotifier {
  late File _direccionvideo;
  File get direccionvideo => this._direccionvideo;
  set direccionvideo(File video) {
    this._direccionvideo = video;
    notifyListeners();
  }
}
