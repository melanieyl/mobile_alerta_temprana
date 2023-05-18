import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_trimmer/video_trimmer.dart';

import '../../providers/formularioprovider.dart';

class TrimmerView extends StatefulWidget {
  final File file;

  TrimmerView({required this.file});

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer
        .saveTrimmedVideo(
            startValue: _startValue,
            endValue: _endValue,
            onSave: (String? outputPath) {
              final File videocortado = File(outputPath.toString());
              final direccionVideoglobal =
                  Provider.of<Formularioprovider>(context, listen: false);
              direccionVideoglobal.direccionvideo = videocortado;
              print('aqui se esta guardando mi resulatado ' +
                  '$direccionVideoglobal');
            })
        .then((value) {
      setState(() {
        _progressVisibility = false;
        // _value = value;
      });
    });

    return _value;
  }

  void _loadVideo() {
    // final direccionVideoglobal =
    //     Provider.of<Formularioprovider>(context, listen: false);
    // File video = direccionVideoglobal.direccionvideo;

    // _trimmer.loadVideo(videoFile: video);
    _trimmer.loadVideo(videoFile: widget.file);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _progressVisibility,
          child: LinearProgressIndicator(
            backgroundColor: Colors.red,
          ),
        ),
        ElevatedButton(
          onPressed: _progressVisibility
              ? null
              : () async {
                  _saveVideo().then((outputPath) {
                    print('OUTPUT PATH: $outputPath');
                    final snackBar =
                        SnackBar(content: Text('Video Saved successfully'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBar,
                    );
                  });
                },
          child: Text("SAVE"),
        ),
        VideoViewer(trimmer: _trimmer),
        Center(
          child: TrimViewer(
            trimmer: _trimmer,
            viewerHeight: 50.0,
            viewerWidth: MediaQuery.of(context).size.width,
            maxVideoLength: const Duration(seconds: 120),
            onChangeStart: (value) => _startValue = value,
            onChangeEnd: (value) => _endValue = value,
            onChangePlaybackState: (value) =>
                setState(() => _isPlaying = value),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                child: _isPlaying
                    ? Icon(
                        Icons.pause,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                onPressed: () async {
                  bool playbackState = await _trimmer.videoPlaybackControl(
                    startValue: _startValue,
                    endValue: _endValue,
                  );
                  setState(() {
                    _isPlaying = playbackState;
                  });
                },
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: _progressVisibility
                    ? null
                    : () async {
                        _saveVideo().then((outputPath) {
                          print('OUTPUT PATH: $outputPath');
                          final snackBar = SnackBar(
                              content: Text('Video Saved successfully'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBar,
                          );
                        });
                      },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
