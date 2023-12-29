import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(20.42796133580664, 75.885749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,

        onMapCreated: (controller) {
          _controller.complete(controller);

          setState(() {});
        },
        myLocationEnabled: true,
        compassEnabled: true,
        initialCameraPosition: cameraPosition,
        markers: Set<Marker>.of(_markers),
        // Marker(
        //   markerId: const MarkerId("current Location"),
        //   position: LatLng(latitude, longitude),
        // )
      ),
    );
  }
}
