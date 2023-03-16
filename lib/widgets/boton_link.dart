import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class BotonLink extends StatelessWidget {
  final String texto;
  final Color color1;
  final Color color2;
  final Function()? onPress;

  const BotonLink(
      {required this.texto,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: OutlinedButton(
          onPressed: this.onPress,
          child: Text(this.texto,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
      width: responsive.wp(40),
      height: responsive.hp(13),
      margin: EdgeInsets.all(responsive.dp(2)),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(4, 6),
                blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: <Color>[
            this.color1,
            this.color2,
          ])),
    );
  }
}

// class BotonLink extends StatelessWidget {
//   final String texto;
//   final Color color1;
//   final Color color2;
//   final Function()? onPress;

//   const BotonLink(
//       {required this.texto,
//       this.color1 = Colors.grey,
//       this.color2 = Colors.blueGrey,
//       required this.onPress});

//   @override
//   Widget build(BuildContext context) {
//     final Responsive responsive = Responsive.of(context);
//     return GestureDetector(
//       onTap: this.onPress,
//       child: Stack(
//         children: <Widget>[
//           _BotonGordoBackground(this.color1, this.color2, this.texto),

//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: <Widget>[
//           //     SizedBox(height: responsive.hp(17), width: responsive.wp(12)),
//           //     SizedBox(width: responsive.wp(2)),
//           //     Expanded(
//           //         child: Text(this.texto,
//           //             style: TextStyle(color: Colors.white, fontSize: 18))),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }
// }

// class _BotonGordoBackground extends StatelessWidget {
//   final Color color1;
//   final Color color2;
//   final String texto;

//   const _BotonGordoBackground(this.color1, this.color2, this.texto);

//   @override
//   Widget build(BuildContext context) {
//     final Responsive responsive = Responsive.of(context);
//     return Container(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
        
//         child: OutlinedButton(
//           onPressed: () {
//             print("Button pressed");
//           },
//           child: Text("TEXT BUTTON"),
//         ),
//       ),
//       width: responsive.wp(40),
//       height: responsive.hp(13),
//       margin: EdgeInsets.all(responsive.dp(2)),
//       decoration: BoxDecoration(
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 offset: Offset(4, 6),
//                 blurRadius: 10),
//           ],
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(colors: <Color>[
//             this.color1,
//             this.color2,
//           ])),
//     );
//   }
// }
