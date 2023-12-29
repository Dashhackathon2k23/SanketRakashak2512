import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/widgets/Service_address_container.dart';
import 'package:rakashkh/widgets/button_widgets.dart';

class ServiceScreen extends StatefulWidget {
  Departments fireModelList;

  ServiceScreen(this.fireModelList, {super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final LatLng _center = LatLng(21.2266, 72.8312);

  late GoogleMapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("himmmmmmmmmmm${widget.fireModelList}");
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            h20,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    w10,
                    SvgPicture.asset(
                      "assets/location-dot.svg",
                      color: Colors.black,
                      width: 25,
                    ),
                    w10,
                    const Text(
                      "Locations Map",
                      style: TextStyle(
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            h20,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Card(
                  elevation: 5,
                  child: GoogleMap(
                    // mapType: MapType.satellite,
                    onMapCreated: _onMapCreated,
                    // myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  ),
                ),
              ),
            ),
            h20,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset("assets/earth-asia-solid.svg",
                        color: Palette.appbar)),
                title: const Text(
                  "Address",
                  style: TextStyle(
                      fontFamily: "Gilroy",
                      color: Palette.appbar,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                trailing: const SizedBox(
                  height: 30,
                  width: 60,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                         Text("ADD", style: TextStyle(color: Palette.appbar)),
                           w5,
                         Icon(
                      Icons.add_circle_outline,
                      color: Palette.appbar,
                    ),
                  ]),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              child: Serviceaddress(
                Address: "wertyuio",
                AddressType: "Home Affress",
                Delete: null,
              ),
            ),
            h10,
            Container(
              child: Serviceaddress(
                Address: "wertyuio",
                AddressType: "Office Affress",
                Delete: null,
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
}
