import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';

import 'package:map_location_picker/map_location_picker.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/screen/address/location_service.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:rakashkh/widgets/text_field_widget.dart';

import 'Service_address_container.dart';

class ServiceScreen extends StatefulWidget {
  ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final LatLng _center = const LatLng(21.2266, 72.8312);
  late AuthenticationProvider authProvider;

  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  double latitude = 0.0;
  double longitude = 0.0;
  var data;
  String currentAddress = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
  }

  Widget build(BuildContext context) {
    authProvider = context.watch<AuthenticationProvider>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 50,
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
                          fontSize: 22),
                    )
                  ],
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
                      markers: {
                        Marker(
                          markerId: const MarkerId("Current location"),
                          position: LatLng(latitude, longitude),
                        ),
                      },
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
                  trailing: SizedBox(
                    height: 30,
                    width: 60,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                print("map hpp");
                                final apiKey =
                                    "AIzaSyBQ9lQB1rZr_WODQi3IeuLFZYbwnGTAC2c";

                                final currentLocation =
                                    await locationService.getCurrentLocation();

                                if (currentLocation == null) {
                                  //showToast("Location is not available!");
                                  print("not available");
                                  return null;
                                }
                                data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return MapLocationPicker(
                                        apiKey: apiKey,
                                        language: "en",
                                        popOnNextButtonTaped: true,
                                        currentLatLng: LatLng(
                                            currentLocation.latitude!,
                                            currentLocation.longitude!),
                                        onNext:
                                            (GeocodingResult? result) async {
                                          print(
                                              "pickNewLocation onNext =====>>> $result");
                                          print(
                                              "hpp ${result!.formattedAddress}");
                                          TextEditingController txtType =
                                              TextEditingController();

                                          if (result.formattedAddress == null) {
                                            return;
                                          }

                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => _addressBox(
                                                result.formattedAddress!,
                                                txtType,
                                              ),
                                            );
                                          });
                                        },
                                        onSuggestionSelected:
                                            (PlacesDetailsResponse? newResult) {
                                          print(
                                              "onSuggestionSelected onSuggestionSelected =====>>> ${newResult?.result.formattedAddress}");

                                          if (newResult!
                                                  .result.formattedAddress ==
                                              null) return;
                                          TextEditingController txtType =
                                              TextEditingController();
                                          final result = newResult!
                                              .result.formattedAddress;
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => _addressBox(
                                                result!,
                                                txtType,
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                );
                                print(">>>>${data}");

                                // WidgetsBinding.instance
                                //     .addPostFrameCallback((timestamp) {
                                // });
                              },
                              child: const Text("ADD",
                                  style: TextStyle(color: Palette.appbar))),
                          w5,
                          const Icon(
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
              h10,
              Container(
                child: Serviceaddress(
                  Address: currentAddress,
                  AddressType: "Current Address",
                  Delete: null,
                ),
              ),
              h10,
              ListView.separated(
                separatorBuilder: (context, index) => h10,
                itemCount: authProvider.userLocationList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  child: Serviceaddress(
                    Address: authProvider.userLocationList[index].address,
                    AddressType: "Office address",
                    Delete: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });
    final position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );

    _controller.future.then((value) {
      value.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latitude, longitude);
    currentAddress =
        "${placeMarks[0].street!}, ${placeMarks[0].subLocality!}, ${placeMarks[0].locality!}, ${placeMarks[0].country!}";
    print("address${currentAddress}");
    setState(() {});
  }

  Widget _addressBox(String address, TextEditingController txtType) {
    return AlertDialog(
      title: const Text("Address"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(address),
          const SizedBox(height: 10),
          TextFormFieldWidget(controller: txtType, hintText: "Address type"),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            UserLocation userLocation =
                UserLocation(address: address, city: txtType.text);
            context
                .read<AuthenticationProvider>()
                .getUserLocation(userLocation);
            Navigator.pop(context);
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
