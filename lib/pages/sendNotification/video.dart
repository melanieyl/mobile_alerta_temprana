// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_alerta_temprana/utils/responsive.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

// class VideoPicker extends StatefulWidget {
//   const VideoPicker({Key? key}) : super(key: key);

//   @override
//   _VideoPickerState createState() => _VideoPickerState();
// }

// class _VideoPickerState extends State<VideoPicker> {
//   File? _videoFile;
//   VideoPlayerController? _videoPlayerController;

//   Future<void> _pickVideo() async {
//     final pickedFile =
//         await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _videoFile = File(pickedFile.path);
//         print('A qui esta mi mensaje' + '$_videoFile');
//         _videoPlayerController = VideoPlayerController.file(_videoFile!);
//         print('A qui esta mi mensaje' + '$_videoPlayerController');
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Responsive responisive = Responsive.of(context);
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: responisive.hp(20),
//           ),
//           ElevatedButton(
//             onPressed: _pickVideo,
//             child: Text('Seleccionar video'),
//           ),
//           if (_videoFile != null && _videoPlayerController != null) ...[
//             SizedBox(height: 16),
//             Text('Video seleccionado:'),
//             SizedBox(height: 8),
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: VideoPlayer(_videoPlayerController!),
//             ),
//           ],
//           if (_videoFile != null && _videoPlayerController != null) ...[
//             SizedBox(height: 16),
//             Text('Video seleccionado:'),
//             SizedBox(height: 8),
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: Chewie(
//                 controller: ChewieController(
//                   videoPlayerController: _videoPlayerController!,
//                   aspectRatio: 16 / 9,
//                   autoInitialize: true,
//                   looping: false,
//                   Agrega otras opciones si lo deseas
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }


// class _VideoPickerState extends State<VideoPicker> {
//   File? _videoFile;

//   Future<void> _pickVideo() async {
//     final pickedFile =
//         await ImagePicker().pickVideo(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _videoFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: _pickVideo,
//           child: Text('Seleccionar video'),
//         ),
//         if (_videoFile != null) ...[
//           SizedBox(height: 16),
//           Text('Video seleccionado:'),
//           SizedBox(height: 8),
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: VideoPlayer(_videoFile!),
//           ),
//         ],
//       ],
//     );
//   }
// }
