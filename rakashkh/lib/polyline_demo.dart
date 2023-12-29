import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakashkh/app/Palette.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.224868, 72.809096),
    zoom: 14,
  );
  final Set<Marker> _markers = {};
  Set<Polygon> _polygone = HashSet<Polygon>();
  final Set<Polyline> _polyline ={};

  List<LatLng> latlog = [
    LatLng(21.224868, 72.809096),
    LatLng(21.218137, 72.833688),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i =0;i<latlog.length; i++)
      {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlog[i],
          infoWindow: InfoWindow(
            title: "my home",
            snippet: "s star rating",
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
        setState(() {

        });
        _polyline.add(
            Polyline(polylineId: PolylineId("1"),
                points: latlog,
              color: Palette.lightBlue,
            )
        );
      }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polygone'),
      ),
      body: GoogleMap(initialCameraPosition: _kGooglePlex,
      markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        polylines: _polyline,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,

      ),
    );
  }
}
