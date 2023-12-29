import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/widgets/button_widgets.dart';

class SettingWithAdmin extends StatefulWidget {
  const SettingWithAdmin({super.key});

  @override
  State<SettingWithAdmin> createState() => _SettingWithAdminState();
}

class _SettingWithAdminState extends State<SettingWithAdmin> {
  TextEditingController adminName = TextEditingController();
  TextEditingController adminNumber = TextEditingController();
  TextEditingController adminDesignation = TextEditingController();

  TextEditingController departmentName = TextEditingController();
  TextEditingController departmentAddress = TextEditingController();
  TextEditingController departmentNumber = TextEditingController();
  TextEditingController departmentCity = TextEditingController();
  TextEditingController departmentState = TextEditingController();

  late GoogleMapController mapController;
  late GoogleMapController mapControllerDepartment;
  final LatLng _center = const LatLng(21.2266, 72.8312);
  final LatLng _centerDepartment = const LatLng(21.2266, 72.8312);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondarycolor,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Palette.commoncolor,
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
                    controller: adminName,
                    decoration: const InputDecoration(
                        hintText: 'Enter your name', border: InputBorder.none),
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
                    controller: adminNumber,
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
                  'Designation',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF253746)),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: adminDesignation,
                    decoration: const InputDecoration(
                        hintText: 'Enter your designation',
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          h10,
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
          h10,
          FilledButtons(
              onTap: () {},
              text: "Edit",
              color: Palette.secondarycolor,
              width: 204,
              height: 50,
              borderRadius: 25),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'DEPARTMENT DETAILS',
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
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: departmentName,
                    decoration: const InputDecoration(
                        hintText: 'Enter Department name',
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
                  'Address',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF253746)),
                ),
                // const SizedBox(width: 87),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: departmentAddress,
                    decoration: const InputDecoration(
                        hintText: 'Enter Department Address',
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
                // const SizedBox(width: 87),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: departmentNumber,
                    decoration: const InputDecoration(
                        hintText: 'Enter Department number',
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
                  'City',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF253746)),
                ),
                // const SizedBox(width: 87),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: departmentCity,
                    decoration: const InputDecoration(
                        hintText: 'Enter Department City',
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
                  'State',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF253746)),
                ),
                // const SizedBox(width: 87),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller: departmentState,
                    decoration: const InputDecoration(
                        hintText: 'Enter Department State',
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          h10,
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
                  'Location',
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
                      onMapCreated: _onMapCreatedDepartment,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: _centerDepartment,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          h10,
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
                  'Image',
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
                    child: Image.asset("assets/fireImage.jpg"),
                  ),
                ),
              ],
            ),
          ),
          h10,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'DEPARTMENT OFFICER',
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
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: ShapeDecoration(
                  color: Palette.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 1)),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20) +
                    const EdgeInsets.only(bottom: 5),
                child: const ListTile(
                  leading: Icon(Icons.account_circle_outlined,
                      size: 46, color: Color(0xFF253746)),
                  title: Row(
                    children: [
                      Text(
                        'Name :',
                        style: TextStyle(
                          color: Color(0xFF253746),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'B.K.Solanki',
                        style: TextStyle(
                          color: Color(0xFF253746),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Designation :',
                            style: TextStyle(
                              color: Color(0xFF253746),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Chief Fire Officer',
                            style: TextStyle(
                              color: Color(0xFF253746),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Phone :',
                            style: TextStyle(
                              color: Color(0xFF253746),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '+91 222-313-4444',
                            style: TextStyle(
                              color: Color(0xFF253746),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Name : ",
                  //       style: TextStyle(color: Palette.appbar),
                  //     ),
                  //     Text(
                  //       "Designation : ",
                  //       style: TextStyle(color: Palette.appbar),
                  //     ),
                  //     Text(
                  //       "Phone : ",
                  //       style: TextStyle(color: Palette.appbar),
                  //     ),
                  //   ],
                  // ),
                ),
              );
            },
          ),
          h10,
          FilledButtons(
              onTap: () {},
              text: "Show More",
              fontSize: 10,
              color: Palette.secondarycolor,
              width: 102,
              height: 20,
              borderRadius: 25),
          FilledButtons(
              onTap: () {},
              text: "Edit",
              color: Palette.secondarycolor,
              width: 204,
              height: 50,
              borderRadius: 25),
          h10,
        ],
      )),
    ));
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapCreatedDepartment(GoogleMapController controller) {
    mapControllerDepartment = controller;
  }
}
