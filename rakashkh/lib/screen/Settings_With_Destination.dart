import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/screen/AddDepartmentScreen.dart';
import 'package:rakashkh/screen/Update_detail_user.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingWithDestinationScreen extends StatefulWidget {
  const SettingWithDestinationScreen({super.key});

  // static String name = "Rakshak";
  // static String designation = "admin";
  // static String mpin = "1234";
  // static String number = "+91 98258455221";
  // static String address =
  //     "Privacy is the utmost concern for most people, and they are hesitant to share any sort of personal information while accessing a website.";

  @override
  State<SettingWithDestinationScreen> createState() =>
      _SettingWithDestinationScreenState();
}

class _SettingWithDestinationScreenState
    extends State<SettingWithDestinationScreen> {
  String? userNumber ;

  TextEditingController txtNameController = TextEditingController();
  TextEditingController txtMNumberController =
      TextEditingController();
  TextEditingController txtDesignationController =
      TextEditingController();

  TextEditingController txtAddressController =
      TextEditingController();



  // TextEditingController txtDeAddressController = TextEditingController();
  // TextEditingController txtDeNameController = TextEditingController();
  // TextEditingController txtDeMNumberController = TextEditingController();
  // TextEditingController txtDeCityController = TextEditingController();
  // TextEditingController txtDeStateController = TextEditingController();
  // TextEditingController txtPinController = TextEditingController();

  bool isHead = false;
  bool _isPasswordVisible = false;
  bool isEdit = false;
  List<IconData> iconList = [
    Icons.saved_search_sharp,
    Icons.explore_outlined,
  ];
  // int _bottomNavIndex = 0;
  final LatLng _center = const LatLng(21.2266, 72.8312);

  late GoogleMapController mapController;
  late AuthenticationProvider authProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //UserNumber
    authProvider = context.read<AuthenticationProvider>();
     userNumber = GetIt.I.get<SharedPreferences>().getString("UserNumber")??"User" ;
    txtMNumberController.text = userNumber!;
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthenticationProvider>();



    return SafeArea(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Palette.secondarycolor,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Palette.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                icon: const Icon(
                  Icons.translate,
                  color: Colors.white,
                ),
                onPressed: () {},
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'USER DETAILS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFF253746),
                      fontSize: 24,
                      fontFamily: "Gilroy-Bold",
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              h5,
              Container(
                height: 50,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF253746)),
                    ),
                    // const SizedBox(width: 87),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        readOnly: !isEdit,
                        controller: txtNameController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              h10,

              Container(
                height: 50,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Number',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF253746)),
                    ),
                    // const SizedBox(width: 70),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        readOnly: !isEdit,
                        controller: txtMNumberController,
                        keyboardType: TextInputType.number,
// maxLength: 10,
                        decoration: const InputDecoration(
                            hintText: 'Enter your number',
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              h10,
              // Visibility(
              //   visible: isHead,
              //   child: Container(
              //     height: 50,
              //     width: double.maxFinite,
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.shade400,
              //           offset: const Offset(0, 4),
              //           blurRadius: 4,
              //         ),
              //       ],
              //     ),
              //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const Text(
              //           'Designation',
              //           style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //               color: Color(0xFF253746)),
              //         ),
              //
              //         SizedBox(
              //           width: 200,
              //           child: TextFormField(
              //             textAlign: TextAlign.end,
              //             controller: txtDesignationController,
              //             decoration: const InputDecoration(
              //                 hintText: 'Enter your designation',
              //                 border: InputBorder.none),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Visibility(
              //   visible: isHead,
              //   child: const SizedBox(
              //     height: 8,
              //   ),
              // ),
              Container(
                height: 180,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF253746)),
                    ),
                    // const SizedBox(width: 50),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: 194,
                        height: 135,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              h15,
              FilledButtons(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UpdateUserDetail(txtNameController.text,txtMNumberController.text

                  );
                },));
              },
              text: "Edit",color: Palette.secondarycolor,width: 204,height: 50,borderRadius: 25),
            h10,
              // FilledButtons(onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
              //     return AddDepartmentScreen();
              //   },));
              //
              // },
              //     text: "Add Department",color: Palette.secondarycolor,width: 204,height: 50,borderRadius: 25),
// h10,
//               FilledButtons(onTap: () {
//                 setState(() {
//                   isHead = !isHead;
//                 });
//
//               }, text: "Trun on Head", color: Palette.secondarycolor,width: 204,height: 50,borderRadius: 25),


          //


              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 130),
              //   child: FloatingActionButton.extended(
              //     onPressed: () {
              //       showModalBottomSheet(
              //         context: context,
              //         builder: (context) => SingleChildScrollView(
              //           child: Column(
              //             children: [
              //               const Padding(
              //                 padding: EdgeInsets.symmetric(vertical: 10),
              //                 child: Center(
              //                   child: Text(
              //                     'USER DETAILS',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 24,
              //                       fontWeight: FontWeight.bold,
              //                       // decoration: TextDecoration.underline,
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 5,
              //               ),
              //               Container(
              //                 height: 50,
              //                 width: double.maxFinite,
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 20),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.grey.shade400,
              //                       offset: const Offset(0, 4),
              //                       blurRadius: 4,
              //                     ),
              //                   ],
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     const Text(
              //                       'Name',
              //                       style: TextStyle(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.bold,
              //                           color: Color(0xFF253746)),
              //                     ),
              //                     const SizedBox(width: 87),
              //                     Expanded(
              //                       child: TextFormField(
              //                         controller: txtNameController,
              //                         decoration: const InputDecoration(
              //                             hintText: 'Enter your name',
              //                             border: InputBorder.none),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 8,
              //               ),
              //               Container(
              //                 height: 50,
              //                 width: double.maxFinite,
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 20),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.grey.shade400,
              //                       offset: const Offset(0, 4),
              //                       blurRadius: 4,
              //                     ),
              //                   ],
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     const Text(
              //                       'Number',
              //                       style: TextStyle(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.bold,
              //                           color: Color(0xFF253746)),
              //                     ),
              //                     const SizedBox(width: 70),
              //                     Expanded(
              //                       child: TextFormField(
              //                         controller: txtMNumberController,
              //                         decoration: const InputDecoration(
              //                             hintText: 'Enter your number',
              //                             border: InputBorder.none),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 8,
              //               ),
              //               Container(
              //                 height: 50,
              //                 width: double.maxFinite,
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 20),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.grey.shade400,
              //                       offset: const Offset(0, 4),
              //                       blurRadius: 4,
              //                     ),
              //                   ],
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     const Text(
              //                       'Designation',
              //                       style: TextStyle(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.bold,
              //                           color: Color(0xFF253746)),
              //                     ),
              //                     const SizedBox(width: 40),
              //                     Expanded(
              //                       child: TextFormField(
              //                         controller: txtDesignationController,
              //                         decoration: const InputDecoration(
              //                             hintText: 'Enter your designation',
              //                             border: InputBorder.none),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 8,
              //               ),
              //               Container(
              //                 height: 150,
              //                 width: double.maxFinite,
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 20),
              //                 decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   boxShadow: [
              //                     BoxShadow(
              //                       color: Colors.grey.shade400,
              //                       offset: const Offset(0, 4),
              //                       blurRadius: 4,
              //                     ),
              //                   ],
              //                 ),
              //                 child: Row(
              //                   children: [
              //                     const Text(
              //                       'Address',
              //                       style: TextStyle(
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.bold,
              //                           color: Color(0xFF253746)),
              //                     ),
              //                     const SizedBox(width: 70),
              //                     Expanded(
              //                         child: Container(
              //                       height: 130,
              //                       width: 150,
              //                       decoration: BoxDecoration(
              //                         color: Colors.grey,
              //                         borderRadius: BorderRadius.circular(10),
              //                       ),
              //                       child: GoogleMap(
              //                         // mapType: MapType.satellite,
              //                         onMapCreated: _onMapCreated,
              //                         // myLocationEnabled: true,
              //                         zoomControlsEnabled: false,
              //                         initialCameraPosition: CameraPosition(
              //                           target: _center,
              //                           zoom: 11.0,
              //                         ),
              //                       ),
              //                     )),
              //                   ],
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 15,
              //               ),
              //               Padding(
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 130),
              //                 child: FloatingActionButton.extended(
              //                   onPressed: () {
              //                     // showModalBottomSheet(
              //                     //   context: context,
              //                     //   builder: (context) => Container(),
              //                     // );
              //                     Navigator.pop(context);
              //                   },
              //                   label: const Text('         Submit         '),
              //                   backgroundColor: Palette.secondarycolor,
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 25,
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //     label: const Text('         Edit         '),
              //     backgroundColor: Palette.secondarycolor,
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   child: Center(
              //     child: Text(
              //       'DEPARTMENT DETAILS',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         color: Color(0xFF253746),
              //         fontSize: 24,
              //         fontWeight: FontWeight.bold,
              //         // decoration: TextDecoration.underline,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'Name',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 87),
              //       Expanded(
              //         child: TextFormField(
              //           controller: txtDeNameController,
              //           decoration: const InputDecoration(
              //               hintText: 'Enter your name',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'Address',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 67),
              //       Expanded(
              //         child: TextFormField(
              //           controller: txtDeAddressController,
              //           decoration: const InputDecoration(
              //               hintText: 'Enter your address',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'Number',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 70),
              //       Expanded(
              //         child: TextFormField(
              //           controller: txtDeMNumberController,
              //           decoration: const InputDecoration(
              //               hintText: 'Enter your number',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'City',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 105),
              //       Expanded(
              //         child: TextFormField(
              //           controller: txtDeCityController,
              //           decoration: const InputDecoration(
              //               hintText: 'Enter your city',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 50,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'State',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 95),
              //       Expanded(
              //         child: TextFormField(
              //           controller: txtDeStateController,
              //           decoration: const InputDecoration(
              //               hintText: 'Enter your state',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 150,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'Location',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 70),
              //       Expanded(
              //         child: Container(
              //           height: 130,
              //           width: 150,
              //           decoration: BoxDecoration(
              //               color: Colors.grey,
              //               borderRadius: BorderRadius.circular(10)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   height: 150,
              //   width: double.maxFinite,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.shade400,
              //         offset: const Offset(0, 4),
              //         blurRadius: 4,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       const Text(
              //         'Image',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Color(0xFF253746)),
              //       ),
              //       const SizedBox(width: 90),
              //       Expanded(
              //         child: Container(
              //           height: 130,
              //           width: 150,
              //           decoration: BoxDecoration(
              //               color: Colors.grey,
              //               borderRadius: BorderRadius.circular(10)),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Container(
              //   width: 430,
              //   height: 280,
              //   decoration: const BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0x26000000),
              //         blurRadius: 8,
              //         offset: Offset(0, 4),
              //         spreadRadius: 0,
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       const Padding(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Center(
              //           child: Text(
              //             'DEPARTMENT Officer',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: Color(0xFF253746),
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               // decoration: TextDecoration.underline,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         width: double.maxFinite,
              //         margin: const EdgeInsets.symmetric(horizontal: 20),
              //         height: 55,
              //         decoration: ShapeDecoration(
              //           color: Colors. Colors.white,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16),
              //           ),
              //           shadows: const [
              //             BoxShadow(
              //               color: Color(0x26000000),
              //               blurRadius: 8,
              //               offset: Offset(0, 4),
              //               spreadRadius: 0,
              //             )
              //           ],
              //         ),
              //         child: const ListTile(
              //           leading: Icon(
              //             Icons.account_circle_outlined,
              //             size: 46,
              //             color: Color(0xFF253746),
              //           ),
              //           title: Row(
              //             children: [
              //               Text(
              //                 'Name :',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 3,
              //               ),
              //               Text(
              //                 'B.K.Solanki',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           subtitle: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Designation :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     'Chief Fire Officer',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Phone :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     '+91 222-313-4444',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Container(
              //         width: double.maxFinite,
              //         margin: const EdgeInsets.symmetric(horizontal: 20),
              //         height: 55,
              //         decoration: ShapeDecoration(
              //           color: Colors. Colors.white,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16),
              //           ),
              //           shadows: const [
              //             BoxShadow(
              //               color: Color(0x26000000),
              //               blurRadius: 8,
              //               offset: Offset(0, 4),
              //               spreadRadius: 0,
              //             )
              //           ],
              //         ),
              //         child: const ListTile(
              //           leading: Icon(
              //             Icons.account_circle_outlined,
              //             size: 46,
              //             color: Color(0xFF253746),
              //           ),
              //           title: Row(
              //             children: [
              //               Text(
              //                 'Name :',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 3,
              //               ),
              //               Text(
              //                 'B.K.Solanki',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           subtitle: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Designation :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     'Chief Fire Officer',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Phone :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     '+91 222-313-4444',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Container(
              //         width: double.maxFinite,
              //         margin: const EdgeInsets.symmetric(horizontal: 20),
              //         height: 55,
              //         decoration: ShapeDecoration(
              //           color: Colors. Colors.white,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16),
              //           ),
              //           shadows: const [
              //             BoxShadow(
              //               color: Color(0x26000000),
              //               blurRadius: 8,
              //               offset: Offset(0, 4),
              //               spreadRadius: 0,
              //             )
              //           ],
              //         ),
              //         child: const ListTile(
              //           leading: Icon(
              //             Icons.account_circle_outlined,
              //             size: 46,
              //             color: Color(0xFF253746),
              //           ),
              //           title: Row(
              //             children: [
              //               Text(
              //                 'Name :',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 3,
              //               ),
              //               Text(
              //                 'B.K.Solanki',
              //                 style: TextStyle(
              //                   color: Color(0xFF253746),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           subtitle: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Designation :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     'Chief Fire Officer',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     'Phone :',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w700,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: 3,
              //                   ),
              //                   Text(
              //                     '+91 222-313-4444',
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w400,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Container(
              //         height: 25,
              //         width: 100,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15),
              //             color: secondaryColor),
              //         child: TextButton(
              //           onPressed: () {},
              //           child: const Text(
              //             'Show More',
              //             style: TextStyle(
              //               color: Colors. Colors.white,
              //               fontSize: 12,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 6,
              // ),
              // Container(
              //   width: 430,
              //   height: 226,
              //   decoration: const BoxDecoration(
              //     color: Colors. Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0x26000000),
              //         blurRadius: 8,
              //         offset: Offset(0, 4),
              //         spreadRadius: 0,
              //       )
              //     ],
              //   ),
              //   child: Column(
              //     children: [
              //       const Padding(
              //         padding: EdgeInsets.symmetric(vertical: 10),
              //         child: Center(
              //           child: Text(
              //             'DEPARTMENT Vehicles',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               color: Color(0xFF253746),
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               // decoration: TextDecoration.underline,
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         width: double.maxFinite,
              //         margin: const EdgeInsets.symmetric(horizontal: 20),
              //         height: 160,
              //         decoration: ShapeDecoration(
              //           color: Colors. Colors.white,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(16),
              //           ),
              //           shadows: const [
              //             BoxShadow(
              //               color: Color(0x26000000),
              //               blurRadius: 8,
              //               offset: Offset(0, 4),
              //               spreadRadius: 0,
              //             )
              //           ],
              //         ),
              //         child: Container(
              //           margin: const EdgeInsets.only(left: 20, right: 20),
              //           height: 160,
              //           width: double.maxFinite,
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'FIRST RESPONDER FIRE ENGINE',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     '05',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               Container(
              //                 height: 3,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: const Color(0xFF253746), // Border color
              //                     width: 2, // Border width
              //                     style: BorderStyle.solid, // Border style
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'WATER BOUSER',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     '06',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               Container(
              //                 height: 3,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: const Color(0xFF253746), // Border color
              //                     width: 2, // Border width
              //                     style: BorderStyle.solid, // Border style
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'BOOM BOUSER',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     '01',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               Container(
              //                 height: 3,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: const Color(0xFF253746), // Border color
              //                     width: 2, // Border width
              //                     style: BorderStyle.solid, // Border style
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'HYDRA CRANE (5 - TON)',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     '01',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               Container(
              //                 height: 3,
              //                 width: double.infinity,
              //                 decoration: BoxDecoration(
              //                   border: Border.all(
              //                     color: const Color(0xFF253746), // Border color
              //                     width: 2, // Border width
              //                     style: BorderStyle.solid, // Border style
              //                   ),
              //                 ),
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //               const Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'Total',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   Text(
              //                     '13',
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                       color: Color(0xFF253746),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               const SizedBox(
              //                 height: 4,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 130),
              //   child: FloatingActionButton.extended(
              //     onPressed: () {
              //       showModalBottomSheet(
              //         context: context,
              //         builder: (context) => Container(),
              //       );
              //     },
              //     label: const Text('         Edit         '),
              //     backgroundColor: secondaryColor,
              //   ),
              // ),
              // const SizedBox(
              //   height: 55,
              // ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: secondaryColor,
        //     child: Container(
        //       padding: const EdgeInsets.all(2),
        //       alignment: Alignment.center,
        //       height: 50,
        //       child: Image.asset('assets/icons/main button.png'),
        //     ),
        //     onPressed: () {}),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   // navigation bar
        //   icons: iconList,
        //   activeIndex: _bottomNavIndex,
        //   gapLocation: GapLocation.center,
        //   notchMargin: 8, // Default notch margin is 8
        //   notchSmoothness: NotchSmoothness.verySmoothEdge,
        //   onTap: (index) => setState(() => _bottomNavIndex = index),
        //   backgroundColor: secondaryColor,
        // ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
