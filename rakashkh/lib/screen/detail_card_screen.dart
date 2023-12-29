import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailCardScreen extends StatefulWidget {
  const DetailCardScreen({super.key});

  @override
  State<DetailCardScreen> createState() => _DetailCardScreenState();
}

class _DetailCardScreenState extends State<DetailCardScreen> {
  final LatLng _center = LatLng(21.2266, 72.8312);

  late GoogleMapController mapController;
  final List<Marker> _markers = <Marker>[];

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(20.42796133580664, 75.885749655962),
    zoom: 14.4746,
  );
  late Uint8List fireMarker;
  late Uint8List policeMarker;
  late Uint8List hospitalMarker;
  late Uint8List common;
  final tab = ["Find", "Service"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
