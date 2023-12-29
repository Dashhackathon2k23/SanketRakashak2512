import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/custom_widget/homaecard.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/screen/Cart_services.dart';
import 'package:rakashkh/screen/Settings_With_Destination.dart';
import 'package:rakashkh/widgets/round_button.dart';

class Homescreenmap extends StatefulWidget {
  @override
  State<Homescreenmap> createState() => _HomescreenmapState();
}

class _HomescreenmapState extends State<Homescreenmap> {
  late MainScreenProvider mainprovider;
  GoogleMapController? _googleMapController;
  double latitude = 21.2266;
  double longitude = 72.8312;

  final LatLng _center = const LatLng(21.2266, 72.8312);
  final List<Marker> _markers = <Marker>[];

  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(20.42796133580664, 75.885749655962),
    zoom: 14.4746,
  );

  late Uint8List fireMarker;
  late Uint8List policeMarker;
  late Uint8List hospitalMarker;
  late Uint8List currentUserMarker;

  String role = "";

  bool cardShow = false;

  late NearestLocationDataModel nearestLocationDataModel;
  DepartmentLocation? model;
  late AuthenticationProvider authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefrences();
    authProvider = context.read<AuthenticationProvider>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Palette.mainColor, // navigation bar color
      statusBarColor: Palette.mainColor, // status bar color
    ));
    _getPermission();
    mainprovider = context.read<MainScreenProvider>();
  }

  Widget build(BuildContext context) {
    mainprovider = context.watch<MainScreenProvider>();
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Palette.appbar,
          ),
          drawer: SettingWithDestinationScreen(),
          // (authProvider.signUpModel!.data!.newUser!.role! == "User" ||
          //     authProvider.loginModel!.data!.user!.role == "User") ? SettingWithDestinationScreen() :SettingWithAdmin(),

          body: Stack(
            children: [
              _googleMap(),
              _scrollDown(),
              _cardForMarker(),
            ],
          )),
    );
  }

  Widget _cardForMarker() {
    return cardShow
        ? Positioned(
            top: 400,
            left: 50,
            child: Stack(
              children: [
                model != null
                    ? HomeCard(
                        address: model!.address,
                        phoneNumber: "902308081031",
                        color: model!.type == "Fire"
                            ? Palette.redLight
                            : model!.type == "Hospital"
                                ? Palette.card_blue
                                : Palette.yellow,
                        stationTitle: model!.slug,
                        stationName: model!.type,
                        svg: model!.type == "Fire"
                            ? "assets/fire.svg"
                            : model!.type == "Hospital"
                                ? "assets/heart-pulse.svg"
                                : "assets/Police.svg",
                        onTap: () {},
                      )
                    : const SizedBox(),
                Positioned(
                  top: 5,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          cardShow = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      )),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _scrollDown() {
    return Positioned(
      bottom: 80,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            SizedBox(width: screenWidth * .30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          duration: const Duration(milliseconds: 400),
                          child: CartServices(
                            isColor: true,
                          )));
                },
                child: const RoundButton(
                    buttonname: "SCROLL DOWN", icon: Icons.arrow_drop_down),
              ),
            ),
            SizedBox(width: screenWidth * .15),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.layers,
                        color: Colors.black,
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleMap() {
    return GoogleMap(
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
    );
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

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    setState(() {});

    mainprovider
        .getNearestLoaction(latitude: latitude, longitude: longitude)
        .then((value) {
      _initializeMap();
    });
  }

  Future<void> _getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();
    getUserCurrentLocation();
  }

  Future<void> _initializeMap() async {
    fireMarker = await getBytesFromAsset("assets/fire.png", 100);
    currentUserMarker = await getBytesFromAsset("assets/user.png", 60);
    createMarker(
      latitude: latitude,
      longitude: longitude,
      icon: currentUserMarker,
      onTap: () {
        setState(() {
          cardShow = true;
        });
      },
    );
    for (var e in mainprovider.firedepartmentLocationList) {
      fireMarker = await getBytesFromAsset("assets/fire.png", 100);
      createMarker(
        latitude: e.location.coordinates[1],
        longitude: e.location.coordinates[0],
        icon: fireMarker,
        onTap: () {
          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }

    for (var e in mainprovider.hospitaldepartmentLocationList) {
      hospitalMarker = await getBytesFromAsset("assets/hospital.png", 100);
      createMarker(
        latitude: e.location.coordinates[1],
        longitude: e.location.coordinates[0],
        icon: hospitalMarker,
        onTap: () {
          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }
    for (var e in mainprovider.policedepartmentLocationList) {
      policeMarker = await getBytesFromAsset("assets/Police.png", 100);
      createMarker(
        latitude: e.location.coordinates[1],
        longitude: e.location.coordinates[0],
        icon: policeMarker,
        onTap: () {
          setState(() {
            model = DepartmentLocation.fromJson(e.toJson());
            cardShow = true;
          });
        },
      );
    }
    setState(() {});
  }

  Future<void> createMarker(
      {required double latitude,
      required double longitude,
      required Uint8List icon,
      void Function()? onTap}) async {
    _markers.add(
      Marker(
        onTap: onTap,
        markerId: MarkerId(UniqueKey().toString()),
        icon: BitmapDescriptor.fromBytes(icon),
        position: LatLng(latitude, longitude),
      ),
    );
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

  void getprefrences() {
    setState(() {
      role = IntroScreen.pref!.getString("role") ?? "";
      final token = IntroScreen.pref!.getString("token") ?? "";
      print("home screen token token $token");
    });
  }
}

// import 'dart:async';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:rakashkh/AdminPanel/Service_page.dart';
// import 'package:rakashkh/app/Palette.dart';
// import 'package:rakashkh/app/globals.dart';
// import 'package:rakashkh/custom_widget/TabItem.dart';
// import 'package:rakashkh/custom_widget/homaecard.dart';
// import 'package:rakashkh/model/nearest_location_data_model.dart';
// import 'package:rakashkh/provider/mainScreenProvider.dart';
// import 'package:rakashkh/screen/Cart_services.dart';
// import 'package:rakashkh/screen/Hosptial_service_details.dart';
// import 'package:rakashkh/screen/Report_screen.dart';
// import 'package:rakashkh/screen/Setting_Admin_mainScreen.dart';
// import 'package:rakashkh/screen/Setting_With_admin.dart';
// import 'package:rakashkh/screen/Settings_With_Destination%20(1).dart';
// import 'package:rakashkh/screen/adrress&service_screen.dart';
// import 'package:rakashkh/screen/googlemapscreen.dart';
// import 'package:rakashkh/widgets/round_button.dart';
//
// class Homescreenmap extends StatefulWidget {
//   @override
//   State<Homescreenmap> createState() => _HomescreenmapState();
// }
//
// class _HomescreenmapState extends State<Homescreenmap> {
//   late MainScreenProvider mainprovider;
//   GoogleMapController? _googleMapController;
//   double latitude = 21.2266;
//   double longitude = 72.8312;
//
//   final LatLng _center = const LatLng(21.2266, 72.8312);
//   final List<Marker> _markers = <Marker>[];
//
//   final Completer<GoogleMapController> _controller = Completer();
//   static const CameraPosition cameraPosition = CameraPosition(
//     target: LatLng(20.42796133580664, 75.885749655962),
//     zoom: 14.4746,
//   );
//   late Uint8List fireMarker;
//   late Uint8List policeMarker;
//   late Uint8List hospitalMarker;
//   final tab = ["Find", "Service"];
//   final page = [const GoogleMapScreen(), const AddressServicesScreen()];
//   int _currentIndex = 0;
//   final Page = [const SettingWithDestinationScreen(), const AddressServicesScreen()];
//
//   void _onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//       Page[index];
//     });
//   }
//
//   final Navigation = [
//     const AddressServicesScreen(),
//     const ReportScreen(),
//   ];
//   bool cardShow = false;
//
//   late NearestLocationDataModel nearestLocationDataModel;
//   DepartmentLocation? model;
//   Departments? fireModel;
//   Departments? policeModel;
//   Departments? hospitalModel;
//   List<Departments> fireModelList = [];
//   List<Departments> policeModelList = [];
//   List<Departments> hospitalModelList = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Palette.mainColor, // navigation bar color
//       statusBarColor: Palette.mainColor, // status bar color
//     ));
//     _getPermission();
//     mainprovider = context.read<MainScreenProvider>();
//   }
//
//   Widget build(BuildContext context) {
//     mainprovider = context.watch<MainScreenProvider>();
//     double screenWidth = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Palette.appbar,
//           ),
//           floatingActionButton: FloatingActionButton(
//               onPressed: () {
//                 _currentIndex = 2;
//               },
//               child: const CircleAvatar(
//                 radius: 80,
//                 backgroundColor: Colors.transparent,
//                 foregroundColor: Colors.transparent,
//                 backgroundImage: AssetImage("assets/main button (1).png"),
//               )),
//           floatingActionButtonLocation:
//               FloatingActionButtonLocation.centerDocked,
//
//           bottomNavigationBar: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(
//                     builder: (context) {
//                       return const AddressServicesScreen();
//                     },
//                   ));
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(15),
//                   child: Image.asset(
//                     "assets/search.png",
//                     height: 30,
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               InkWell(
//                 onTap: () {
//                   Navigator.pushReplacement(context, MaterialPageRoute(
//                     builder: (context) {
//                       return const AddressServicesScreen();
//                     },
//                   ));
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(15),
//                   child: Image.asset(
//                     "assets/compass.png",
//                     height: 30,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           drawer: SizedBox(
//             width: screenWidth,
//             child: Drawer(
//
//               child: ListView(
//                 children: [
//                   AppBar(
//                       title: const Center(
//                         child: Text(
//                           "Settings",
//                           style: TextStyle(color: Palette.white,fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       actions: [
//                         IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: const Icon(color: Palette.white,
//                               Icons.close,
//                               size: 25,
//                             ))
//                       ],
//                       backgroundColor: Palette.appbar),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Notification',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Admin pannal',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const Service_Page();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Admin pannal',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const AddressServicesScreen();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Setting with destination',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const SettingWithDestinationScreen();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Setting with destination',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const ReportScreen();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('Setting with admin',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const SettingWithAdmin();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundColor: Palette.appbar,
//                       maxRadius: 30,
//                       child: Icon(
//                         Icons.notifications_none_outlined,
//                         size: 30,
//                         color: Palette.commonColor,
//                       ),
//                     ),
//                     title: const Text('basic admin',
//                         style: TextStyle(
//                             fontFamily: "Gilroy",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20)),
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const SettingAdminBasicScreen();
//                           // return AddService();
//                         },
//                       ));
//                     },
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           body: Stack(
//             children: [
//               _googleMap(),
//               _scrollDown(),
//               _cardForMarker(),
//             ],
//           )),
//     );
//   }
//
//   Widget _cardForMarker() {
//     return cardShow
//         ? Positioned(
//             top: 400,
//             left: 50,
//             child: Stack(
//               children: [
//                 model != null
//                     ? HomeCard(
//                         address: model!.address,
//                         phoneNumber: "902308081031",
//                         color: model!.type == "Fire"
//                             ? Palette.redLight
//                             : model!.type == "Hospital"
//                                 ? Palette.card_blue
//                                 : Palette.yellow,
//                         stationTitle: model!.slug,
//                         stationName: model!.type,
//                         svg: model!.type == "Fire"
//                             ? "assets/fire.svg"
//                             : model!.type == "Hospital"
//                                 ? "assets/heart-pulse.svg"
//                                 : "assets/Police.svg",
//                         onTap: () {
//                           print(
//                               "${model!.sId}  ${model!.name}   ${model!.address}");
//
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return HOspitalServiceDetail(fireModelList[0]);
//                             },
//                           ));
//                         },
//                       )
//                     : const SizedBox(),
//                 Positioned(
//                   top: 5,
//                   child: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           cardShow = false;
//                         });
//                       },
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                         size: 25,
//                       )),
//                 )
//               ],
//             ),
//           )
//         : const SizedBox();
//   }
//
//   Widget _scrollDown() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Row(
//         children: [
//           SizedBox(width: screenWidth * .30),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 40),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     PageTransition(
//                         type: PageTransitionType.bottomToTop,
//                         duration: const Duration(milliseconds: 400),
//                         child: const CartServices()));
//               },
//               child: const RoundButton(
//                   buttonname: "SCROLL DOWN", icon: Icons.arrow_drop_down),
//             ),
//           ),
//           SizedBox(width: screenWidth * .15),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 40),
//             child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.layers,
//                       color: Colors.black,
//                     ))),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _googleMap() {
//     return GoogleMap(
//       mapType: MapType.normal,
//       myLocationButtonEnabled: true,
//       zoomControlsEnabled: false,
//
//       onMapCreated: (controller) {
//         _controller.complete(controller);
//
//         setState(() {});
//       },
//       myLocationEnabled: true,
//       compassEnabled: true,
//       initialCameraPosition: cameraPosition,
//       markers: Set<Marker>.of(_markers),
//       // Marker(
//       //   markerId: const MarkerId("current Location"),
//       //   position: LatLng(latitude, longitude),
//       // )
//     );
//   }
//
//   _buildBottomTab() {
//     return BottomAppBar(
//       color: Palette.commoncolor,
//       shape: const CircularNotchedRectangle(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           TabItem(
//             tab[0],
//             onTap: () {},
//             image: 'assets/search.png',
//           ),
//           const SizedBox(
//             width: 25,
//           ),
//           TabItem(
//             tab[1],
//             onTap: () {},
//             image: 'assets/compass.png',
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) async {
//       await Geolocator.requestPermission();
//     });
//     final position = await Geolocator.getCurrentPosition();
//     latitude = position.latitude;
//     longitude = position.longitude;
//     CameraPosition cameraPosition = CameraPosition(
//       target: LatLng(position.latitude, position.longitude),
//       zoom: 14,
//     );
//
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(cameraPosition),
//     );
//
//     setState(() {});
//
//     mainprovider
//         .getNearestLoaction(latitude: latitude, longitude: longitude)
//         .then((value) {
//       _initializeMap();
//     });
//   }
//
//   Future<void> _getPermission() async {
//     var satus = await Permission.location.serviceStatus;
//     if (satus.isEnabled) {
//       await [
//         Permission.location,
//       ].request();
//     }
//     getUserCurrentLocation();
//   }
//
//   Future<void> _initializeMap() async {
//     fireMarker = await getBytesFromAsset("assets/fire.png", 100);
//     createMarker(
//       latitude: latitude,
//       longitude: longitude,
//       icon: fireMarker,
//       onTap: () {
//         setState(() {
//           cardShow = true;
//         });
//       },
//     );
//     for (var e in mainprovider.firedepartmentLocationList) {
//       fireMarker = await getBytesFromAsset("assets/fire.png", 100);
//       createMarker(
//         latitude: e.location.coordinates[1],
//         longitude: e.location.coordinates[0],
//         icon: fireMarker,
//         onTap: () {
//           setState(() {
//             model = DepartmentLocation.fromJson(e.toJson());
//             cardShow = true;
//           });
//         },
//       );
//     }
//
//     for (var e in mainprovider.hospitaldepartmentLocationList) {
//       hospitalMarker = await getBytesFromAsset("assets/hospital.png", 100);
//       createMarker(
//         latitude: e.location.coordinates[1],
//         longitude: e.location.coordinates[0],
//         icon: hospitalMarker,
//         onTap: () {
//           setState(() {
//             model = DepartmentLocation.fromJson(e.toJson());
//             cardShow = true;
//           });
//         },
//       );
//     }
//     for (var e in mainprovider.policedepartmentLocationList) {
//       policeMarker = await getBytesFromAsset("assets/Police.png", 100);
//       createMarker(
//         latitude: e.location.coordinates[1],
//         longitude: e.location.coordinates[0],
//         icon: policeMarker,
//         onTap: () {
//           setState(() {
//             model = DepartmentLocation.fromJson(e.toJson());
//             cardShow = true;
//           });
//         },
//       );
//     }
//     setState(() {});
//   }
//
//   Future<void> createMarker(
//       {required double latitude,
//       required double longitude,
//       required Uint8List icon,
//       void Function()? onTap}) async {
//     _markers.add(
//       Marker(
//         onTap: onTap,
//         markerId: MarkerId(UniqueKey().toString()),
//         icon: BitmapDescriptor.fromBytes(icon),
//         position: LatLng(latitude, longitude),
//       ),
//     );
//   }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
// }
