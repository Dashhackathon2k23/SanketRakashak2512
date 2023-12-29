import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/model/GetAllVehicle.dart';
import 'package:rakashkh/provider/getAllVehicle.dart';
import 'package:rakashkh/screen/Update_detail_user.dart';
import 'package:rakashkh/widgets/button_widgets.dart';

class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({super.key});

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  TextEditingController StationName = TextEditingController();
  TextEditingController ContactNumber = TextEditingController();
  TextEditingController StationLoaction = TextEditingController();
  TextEditingController CityName = TextEditingController();
  TextEditingController StateName = TextEditingController();

  File? imageFile;
  final ImagePicker picker = ImagePicker();
  XFile? _image;
  File? imagePicked;
  List<File> selectedImages = [];

  String selectedCity = 'All';
  String selectedDesignation = ' Chief Fire Officer';
  List<String> designation = [" Chief Fire Officer", "Fire Workers"];
  late GetAllVehicles getAllVehicles;

  GetAllVehicle? getAllVehicle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllVehicles = context.read<GetAllVehicles>();
  }

  @override
  Widget build(BuildContext context) {
    getAllVehicles = context.watch<GetAllVehicles>();
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Palette.secondarycolor,
        centerTitle: true,
        title: const Text(
          'Service',
          style: TextStyle(
            color: Palette.commonColor,
            fontFamily: "Gilroy",
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
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: StationName,
                cursorColor: Palette.appbar,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.maps_home_work_outlined,
                        color: Palette.subappbar),
                    hintText: "Enter Station Name",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: ContactNumber,
                cursorColor: Palette.appbar,
                keyboardType: TextInputType.number,
                // maxLength: 10,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.call_outlined, color: Palette.subappbar),
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: StationLoaction,
                cursorColor: Palette.appbar,
                keyboardType: TextInputType.streetAddress,
                // maxLength: 10,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.location_pin, color: Palette.subappbar),
                    hintText: "Enter Station Address",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: CityName,
                cursorColor: Palette.appbar,
                keyboardType: TextInputType.name,
                // maxLength: 10,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.location_city_outlined,
                        color: Palette.subappbar),
                    hintText: "Enter City Name",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: StateName,
                cursorColor: Palette.appbar,
                keyboardType: TextInputType.name,
                // maxLength: 10,
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.language, color: Palette.subappbar),
                    hintText: "Enter State Name",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            h10,
            Row(
              children: [
                w20,
                w5,
                const Icon(Icons.image_outlined, color: Palette.subappbar),
                w20,
                w20,
                w10,
                FilledButtons(
                  onTap: pickImageByCamera,
                  fontSize: 15,
                  text: "Browse Files",
                  color: Palette.appbar,
                  height: 20,
                  width: 200,
                  borderRadius: 25,
                )
              ],
            ),
            h5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                w5,
                const Icon(
                  Icons.car_crash_outlined,
                  color: Palette.subappbar,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 45,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        size: 30, color: Palette.appbar),
                    value: selectedDesignation,
                    underline: Container(),
                    isExpanded: true,
                    hint: const Center(
                      child: Text("Add cheif fire offiers",
                          style: TextStyle(
                            fontFamily: "Gilroy",
                          )),
                    ),
                    items: designation.map((organization) {
                      return DropdownMenuItem(
                        alignment: Alignment.center,
                        value: organization,
                        child: Text(organization),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDesignation = value!;
                      });
                    },
                  ),
                ),
                Container(
                  width: 34,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: const Center(child: Text("0")),
                ),
                Container(
                  width: 34,
                  height: 30,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: const Icon(Icons.add, size: 18),
                ),
              ],
            ),
            h10,
            FilledButtons(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return UpdateUserDetail(" ", " ");
                    },
                  ));
                },
                text: "Submit",
                color: Palette.appbar,
                width: 204,
                height: 50,
                borderRadius: 25),
            // Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.red,
            //     child: selectedImages.isEmpty
            //         ? Container()
            //         : Image.file(selectedImages[0])),
          ],
        ),
      ),
    ));
  }

  Future<void> pickImageByCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // Now, you can pick the image using the camera
      try {
        final XFile? pickedFileImage = await picker.pickImage(
          source: ImageSource.camera,
        );
        if (pickedFileImage != null) {
          selectedImages.add(File(pickedFileImage.path));
        } else {
          print('Camera permission denied');
        }
      } catch (e) {
        print('Error picking image from camera: $e');
      }
    }
  }

  void cameraImage() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imagePicked = pickedImageFile;
    });
  }
}
