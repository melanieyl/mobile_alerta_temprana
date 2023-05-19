import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class VideoCamera extends StatelessWidget {
  final void Function()? onpressed;
  const VideoCamera({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return AlertDialog(
      content: SizedBox(
        height: responsive.hp(20),
        child: Column(children: [
          InkWell(
            onTap: this.onpressed,
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
            onTap: this.onpressed,
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
        ]),
      ),
    );
  }
}
