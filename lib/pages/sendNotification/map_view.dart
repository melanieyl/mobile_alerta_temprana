import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_View extends StatefulWidget {
  final double latitud;
  final double longitud;

  const Map_View({Key? key, required this.latitud, required this.longitud})
      : super(key: key);

  @override
  _Map_ViewState createState() => _Map_ViewState();
}

class _Map_ViewState extends State<Map_View> {
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    LatLng initialLocation = LatLng(widget.latitud, widget.longitud);
    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height / 2,
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        compassEnabled: false,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (LatLng location) {
          setState(() {
            selectedLocation = location;
          });
        },
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selected_location'),
                  position: selectedLocation!,
                  icon: BitmapDescriptor.defaultMarker,
                )
              }
            : {},
      ),
    );
  }
}
