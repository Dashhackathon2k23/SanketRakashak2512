import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/custom_widget/TabItem.dart';
import 'dart:ui' as ui;

import 'package:rakashkh/model/nearest_location_data_model.dart';

class HOspitalServiceDetail extends StatefulWidget {
  Departments policeModelList;

  HOspitalServiceDetail(this.policeModelList, {super.key});

  @override
  State<HOspitalServiceDetail> createState() => _HOspitalServiceDetailState();
}

class _HOspitalServiceDetailState extends State<HOspitalServiceDetail> {
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
  late Uint8List commonMarker;
  late String common;
  final tab = ["Find", "Service"];

  @override
  void initState() {
    // TODO: implement initState
    _initlization();
    super.initState();
  }

  _initlization() async {
    fireMarker = await getBytesFromAsset("assets/fire.png", 100);
    policeMarker = await getBytesFromAsset("assets/hospital.png", 100);
    hospitalMarker = await getBytesFromAsset("assets/Police.png", 100);
    if (widget.policeModelList.type == "Fire") {
      setState(() {
        common = "assets/fire.png";
      });
    }
    if (widget.policeModelList.type == "police") {
      setState(() {
        common = "assets/police.png";
      });
    }
    if (widget.policeModelList.type == "Hospital") {
      setState(() {
        common = "assets/hospital.png";
      });
    }
    commonMarker = await getBytesFromAsset(common, 100);

    _markers.add(
      Marker(
        onTap: () {},
        markerId: MarkerId(UniqueKey().toString()),
        icon: BitmapDescriptor.fromBytes(commonMarker),
        position: LatLng(widget.policeModelList.location!.coordinates![1],
            widget.policeModelList.location!.coordinates![0]),
      ),
    );
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.policeModelList.location!.coordinates![1],
          widget.policeModelList.location!.coordinates![0]),
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    setState(() {});

    print("lanjbdj${widget.policeModelList.location!.coordinates![1]}");
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.appbar,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              backgroundImage: AssetImage("assets/main button.png"),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomTab(),
        body: Column(
          children: [
            Container(
              margin:const  EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:const  [BoxShadow(color: Colors.white, blurRadius: 10)]),
              height: 280,
              child: GoogleMap(
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
              ),
            ),
            h10,
            Container(
              height: 100,

              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: const [
                 BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                    spreadRadius: 0,
                  )
                ],
              ),
              // decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h10,
                  Row(
                    children: [
                      w10,
                      SvgPicture.asset(
                        "assets/map-location.svg",
                        color: Palette.card_blue,
                        width: 25,
                        height: 25,
                      ),
                      w10,
                     const  Text("Address",
                          style: TextStyle(
                              color: Palette.card_blue,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                 const  Divider(
                      color: Palette.card_blue,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: Text("${widget.policeModelList.address}"),
                  ),
                ],
              ),
            ),
            h10,
            Container(
              height: 100,

              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows:const [
                   BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                    spreadRadius: 0,
                  )
                ],
              ),
              // decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h10,
                  Row(
                    children: [
                      w10,
                      SvgPicture.asset(
                        "assets/phone.svg",
                        color: Palette.card_blue,
                        width: 25,
                        height: 25,
                      ),
                      w10,
                      const Text("Contact",
                          style: TextStyle(
                              color: Palette.card_blue,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                  const Divider(
                      color: Palette.card_blue,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 25),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(removeBrackets("${widget.policeModelList.number}")),
                        Text(removeBrackets("${widget.policeModelList.number}")),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            h10,
            Container(
              height: 100,

              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                    spreadRadius: 0,
                  )
                ],
              ),
              // decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h10,
                  Row(
                    children: [
                      w10,
                      SvgPicture.asset(
                        "assets/user-regular.svg",
                        color: Palette.card_blue,
                        width: 25,
                        height: 25,
                      ),
                      w10,
                      Text("Head",
                          style: TextStyle(
                              color: Palette.card_blue,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                  Divider(
                      color: Palette.card_blue,
                      thickness: 1.5,
                      indent: 10,
                      endIndent: 20),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 25),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\u2022 Name:B.K. Solanki"),
                          Text("\u2022 Name:${widget.policeModelList.sId}"),
                          Text("\u2022 Designation :F.O."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _buildBottomTab() {
    return BottomAppBar(
      color: Palette.commoncolor,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TabItem(
            tab[0],
            onTap: () {},
            image: 'assets/search.png',
          ),
          const SizedBox(
            width: 25,
          ),
          TabItem(
            tab[1],
            onTap: () {},
            image: 'assets/compass.png',
          ),
        ],
      ),
    );
  }
  String removeBrackets(String input) {
    if (input.startsWith('[') && input.endsWith(']')) {
      return input.substring(1, input.length - 1);
    } else if (input.startsWith('{') && input.endsWith('}')) {
      return input.substring(1, input.length - 1);
    } else if (input.startsWith('(') && input.endsWith(')')) {
      return input.substring(1, input.length - 1);
    } else {
      return input;
    }
  }
}
