import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/custom_widget/cards.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/provider/reportProvider.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/utils/toastMassage.dart';
import 'package:rakashkh/videoscreen.dart';
import 'package:rakashkh/widgets/card_title.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController describeController = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  String selectedDesignation = 'Current Location';
  List<String> designation = ["Current Location", "Home Location" , "Office Address"];

  List<File> selectedImages = [];
  final ImagePicker picker = ImagePicker();
  XFile? _image;
  File? imageFile;
  bool isVideo = false;


  late PageController _pageController;
  late MainScreenProvider mainprovider;
  late ReportProvider reportProvider;

  Departments? fireModel;
  Departments? policeModel;
  Departments? hospitalModel;
  List<Departments> fireModelList = [];
  List<Departments> policeModelList = [];
  List<Departments> hospitalModelList = [];

  String? token = IntroScreen.pref!.getString("token");
  String? userNumber = IntroScreen.pref!.getString("UserNumber");

  int fire = 0;
  int hospital = 0;
  int police = 0;
  bool isCheck = false;

  bool initialFire = false;
  bool initialHospital = false;
  bool initialPolice = false;
  List<String> departmentId = [];

  int? FireId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainprovider = context.read<MainScreenProvider>();
    reportProvider = context.read<ReportProvider>();
    print(" when i page open => ${selectedImages}");


    for (var x in mainprovider.fireList) {
      fireModel = Departments.fromJson(x.toJson());
      fireModelList.add(fireModel!);
    }
    for (var x in mainprovider.policeList) {
      policeModel = Departments.fromJson(x.toJson());
      policeModelList.add(policeModel!);
    }
    for (var x in mainprovider.hospitalDataList) {
      hospitalModel = Departments.fromJson(x.toJson());
      hospitalModelList.add(hospitalModel!);
    }
    token = IntroScreen.pref!.getString("token");
    userNumber = IntroScreen.pref!.getString("UserNumber");
    print("token is ${token} ${userNumber}");

    setState(() {});
  }

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    mainprovider = context.watch<MainScreenProvider>();
    reportProvider = context.watch<ReportProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.appbar,
        appBar: AppBar(
          actions: [IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.close,color: Palette.white,))],
          title: const Center(
              child: Text(
            "REPORT",
            style:
                TextStyle(fontSize: 28, decoration: TextDecoration.underline),
          )),
          backgroundColor: Palette.appbar,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            h10,
            const Center(
              child: Text("SELECT LOCATION",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Palette.commoncolor,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            h5,
            Container(
              padding: const EdgeInsets.all(10),
              height: 45,
              width: 280,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down,
                    size: 30, color: Palette.appbar),
                value: selectedDesignation,
                underline: Container(),
                elevation: 5,
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
            h10,
            const Divider(
              height: 3,
              color: Colors.white,
              indent: 20,
              endIndent: 20,
            ),
            h10,
            Visibility(
              visible: token!.isEmpty,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30) +
                    const EdgeInsets.only(bottom: 5),
                // padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  cursorColor: Palette.appbar,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Your Contact Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  controller: contactNumber,
                ),
              ),
            ),
            const Text("SELECT SERVICE",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Palette.commoncolor,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            _cardWidget(),
            const Divider(
              height: 3,
              color: Colors.white,
              indent: 20,
              endIndent: 20,
            ),
            h10,
            Column(
              children: [
                InkWell(
                  onTap: showDataAlert,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 100,
                        height: 100,
                        decoration: ShapeDecoration(
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/fireImage.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const Icon(Icons.camera_alt_outlined,
                          color: Colors.white60, size: 35),
                    ],
                  ),
                ),
                h10,
                selectedImages.isNotEmpty
                    ? SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            if (isImageOrVideoFile(
                                    selectedImages[index].path) ==
                                true) {
                              // photo
                              return Card(
                                elevation: 5,
                                child: Container(
                                  margin: const EdgeInsets.all(2) +
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  // height: 200,
                                  child: SizedBox(
                                    child: Image.file(selectedImages[index]),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) {
                                      return VideoPlayerScreen(
                                        key: UniqueKey(),
                                        selectedImages[index],
                                        isPreview: false,
                                      );
                                    },
                                  ),
                                ),
                                child: Card(
                                  elevation: 5,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.all(4),
                                        child: VideoPlayerScreen(
                                          selectedImages[index],
                                          isPreview: true,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.play_circle,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            h10,
            _sizebox(),
            h10,
            const Center(
              child: Text("DESCRIBE",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Palette.commoncolor,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            ),
            h5,
            _typeBox(),
            h10,
            _sizebox(),
            h10,
            _sendButton(),
            h10,
          ]),
        ),
      ),
    );
  }

  Widget _cardWidget() {
    return Container(
      color: Palette.mainColor,
      child: Column(
        children: [
          CardTitle(
            color: Colors.red,
            departmanet: "FIRE SERVICE",
            svg: "assets/fire.svg",
          ),
          CarouselSlider.builder(
            carouselController: CarouselController(),
            itemCount: fireModelList.length,
            itemBuilder: (BuildContext context, int i, int pageViewIndex) {
              return fireModelList != null
                  ? CardWidget(
                shadow: false,
                address: fireModelList[i].address,
                // phoneNumber: "${fireModelList[i].number}",
                phoneNumber: removeBrackets("${fireModelList[i].number}"),
                stationName: fireModelList[i].name,
                color: initialFire
                    ? i == fire
                    ? Colors.green
                    : Palette.redLight
                    : Palette.redLight,
                svg: 'assets/fire.svg',
                onTap: () {
                  initialFire = true;
                  departmentId.add(fireModelList[fire].sId.toString());
                  setState(() {});
                  // fireModelList[i].sId;
                  // print("fire sid => ${ fireModelList[i].sId}");

                },
                stationTitle: fireModelList[i].name,
                  // ischeck: isCheck
              )
                  : SizedBox();
            },
            options: CarouselOptions(
                height: 215.0,
                enableInfiniteScroll: false,
                initialPage: 0,
                enlargeCenterPage: false,
                viewportFraction: .85),
          ),
          // SizedBox(height: 15),
          CardTitle(
            color: Palette.yellow,
            departmanet: "POLICE SERVICES",
            svg: "assets/shield-halved-solid.svg",
          ),
          CarouselSlider.builder(
            itemCount: policeModelList.length,
            itemBuilder: (BuildContext context, int i, int pageViewIndex) {
              return policeModelList != null
                  ? CardWidget(
                shadow: false,
                address: policeModelList[i].address,
                // phoneNumber: "${policeModelList[i].number}",
                phoneNumber:
                removeBrackets("${policeModelList[i].number}"),
                stationName: policeModelList[i].name,
                color: initialPolice
                    ? i == police
                    ? Colors.green
                    : Palette.yellow
                    : Palette.yellow,
                svg: 'assets/shield-halved-solid.svg',
                onTap: () {
                  initialPolice = true;
                  police = i;
                  departmentId.add(policeModelList[police].sId.toString());

                  // policeModelList[i].sId;
                  // print("police sid => ${ policeModelList[i].sId}");
                  setState(() {});
                },
                stationTitle: policeModelList[i].name,
                // ischeck: false,
              )
                  : SizedBox();
            },
            options: CarouselOptions(
                height: 215.0,
                enableInfiniteScroll: false,
                initialPage: 0,
                enlargeCenterPage: false,
                viewportFraction: .85),
          ),

          CardTitle(
            color: Palette.card_blue,
            departmanet: "HOSPITAL SERVICE",
            svg: "assets/heart-pulse.svg",
          ),
          CarouselSlider.builder(
            itemCount: hospitalModelList.length,
            itemBuilder: (BuildContext context, int i, int pageViewIndex) {
              return hospitalModelList != null
                  ? CardWidget(
                shadow: false,
                address: hospitalModelList[i].address,
                // phoneNumber: "${hospitalModelList[i].number}",
                phoneNumber:
                removeBrackets("${hospitalModelList[i].number}"),
                stationName: "${hospitalModelList[i].name}",
                color: initialHospital
                    ? i == hospital
                    ? Colors.green
                    : Palette.card_blue
                    : Palette.card_blue,
                svg: "assets/heart-pulse.svg",
                onTap: () {
                  initialHospital = true;
                  hospital = i;
                  departmentId.add(hospitalModelList[police].sId.toString());
                  setState(() {});

                  // hospitalModelList[i].sId;
                  // print("Hospital sid => ${ hospitalModelList[i].sId}");
                },
                stationTitle: hospitalModelList[i].name,
                // ischeck: false,
              )
                  : const SizedBox();
            },
            options: CarouselOptions(
                height: 215.0,
                enableInfiniteScroll: false,
                initialPage: 0,
                enlargeCenterPage: false,
                viewportFraction: .85),
          ),
        ],
      ),
    );
  }

  Widget _sizebox(){
    return const Divider(
      height: 3,
      color: Colors.white,
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _typeBox() {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        cursorColor: Palette.appbar,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Type..",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        controller: describeController,
      ),
    );
  }

  Widget _sendButton()
  {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Palette.card_blue,
              side: const BorderSide(
                  width: 2, color: Palette.commoncolor)),
          onPressed: () {
            print("when i image uplorad and submit =>${selectedImages[0]}");
            var loc = [72.90135322499115,21.25141024985171];
            List<String> departmentSid = ["655dc53e51f90d0385322a18","655dc53e51f90d0385322a18"];
            String deptid = "655dc53e51f90d0385322a18" ;
            print("type == >${departmentSid[0].runtimeType}");
            reportProvider.ReportDioApi(selectedImages[0],loc,userNumber!,
                // departmentSid.toList(),
                departmentId,
                describeController.text,deptid).then((value) {
              if(value)
                {
                  ToastMassage().toastMeassage("Report uplord succesfly");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Homescreenmap();
                          },));
                }
              else
                {
                      print("invalid data");

                }
            },);

          },
          child: const Text(
            "SEND",
            style: TextStyle(fontSize: 20),
          )),
    );
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Center(
              child: Text(
                "Image",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            pickImageByCamera();
                            // pickImageByGallery();
                          },
                          child: Image.asset("assets/camera.png",
                              height: 50, width: 50)),
                    ],
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                  h10,
                  const Center(
                    child: Text(
                      "Video",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            print(" when i tap on camera => ${selectedImages}");
                            Navigator.pop(context);
                            pickVideoByCamera();
                          },
                          child: Image.asset("assets/camera.png",
                              height: 50, width: 50)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool? isImageOrVideoFile(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();

    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];

    final fileExtension = path.extension(lowerCaseFileName);

    if (imageExtensions.contains(fileExtension)) {
      return true;
    } else if (videoExtensions.contains(fileExtension)) {
      return false;
    } else {
      return null;
    }
  }

  Future pickImageByGallery() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      print("imgae path == > ${selectedImages[0]}");
      setState(
        () {},
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  Future pickImageByCamera() async {
    final XFile? pickedFileImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFileImage != null) {
      setState(() {
        selectedImages.add(File(pickedFileImage.path));
      });
    }
  }

  Future pickVideoByCamera() async {
    final XFile? pickedFileVideo =
        await picker.pickVideo(source: ImageSource.camera);
    if (pickedFileVideo != null) {
      setState(() {
        selectedImages.add(File(pickedFileVideo.path));
      });
    }
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

// import 'dart:io';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// // import 'package:image_picker/image_picker.dart';
// //
// // import 'package:image_picker_platform_interface/src/types/image_source.dart' as picker;
// import 'package:rakashkh/app/Palette.dart';
// import 'package:rakashkh/app/dimensions.dart';
// import 'package:rakashkh/custom_widget/cards.dart';
// import 'package:rakashkh/videoscreen.dart';
// import 'package:rakashkh/widgets/card_title.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path/path.dart' as path;
//
// class ReportScreen extends StatefulWidget {
//   const ReportScreen({super.key});
//
//   @override
//   State<ReportScreen> createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreen> {
//   TextEditingController describeController = TextEditingController();
//   String selectedDesignation = 'Chief Fire Officer';
//   List<String> designation = ["Chief Fire Officer", "Fire Workers"];
//
//
//
//   List<File> selectedImages = [];
//   final ImagePicker picker = ImagePicker();
//   XFile? _image;
//   File? imageFile;
//   bool isVideo = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//     final screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Palette.appbar,
//         appBar: AppBar(
//           title: const Center(
//               child: Text(
//                 "REPORT",
//                 style:
//                 TextStyle(fontSize: 28, decoration: TextDecoration.underline),
//               )),
//           backgroundColor: Palette.appbar,
//           automaticallyImplyLeading: false,
//         ),
//         body: SingleChildScrollView(
//           child: Column(children: [
//             h10,
//             const Center(
//               child: Text("SELECT LOCATION",
//                   style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Palette.commoncolor,
//                       fontFamily: "Gilroy",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20)),
//             ),
//             h5,
//             Container(
//               padding: const EdgeInsets.all(10),
//               height: 45,
//               width: 280,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white,
//                   border: Border.all(color: Colors.black)),
//               margin: const EdgeInsets.symmetric(horizontal: 10),
//               child: DropdownButton(
//                 icon: const Icon(Icons.keyboard_arrow_down,
//                     size: 30, color: Palette.appbar),
//                 value: selectedDesignation,
//                 underline: Container(),
//                 elevation: 5,
//                 isExpanded: true,
//                 hint: const Center(
//                   child: Text("Add cheif fire offiers",
//                       style: TextStyle(
//                         fontFamily: "Gilroy",
//                       )),
//                 ),
//                 items: designation.map((organization) {
//                   return DropdownMenuItem(
//                     alignment: Alignment.center,
//                     value: organization,
//                     child: Text(organization),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedDesignation = value!;
//                   });
//                 },
//               ),
//             ),
//             h10,
//             const Divider(
//               height: 3,
//               color: Colors.white,
//               indent: 20,
//               endIndent: 20,
//             ),
//             h10,
//             const Text("SELECT SERVICE",
//                 style: TextStyle(
//                     decoration: TextDecoration.underline,
//                     color: Palette.commoncolor,
//                     fontFamily: "Gilroy",
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20)),
//             Column(
//               children: [
//                 CardTitle(
//                   color: Colors.red,
//                   departmanet: "FIRE SERVICE",
//                   svg: "assets/fire.svg",
//                 ),
//                 CarouselSlider.builder(
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, int itemIndex,
//                       int pageViewIndex) =>
//                       CardWidget(
//                         address:
//                         ': 6V4Q+R29, Unnamed Road, Vrundavan Society, Yoginagar Society, Surat, Gujarat 395010',
//                         phoneNumber: '111-222-3333',
//                         stationName: 'Puna gam Fire Station',
//                         stationTitle: 'Puna Gam Fire Station, Puna gam',
//                         color: Palette.colorPrimary,
//                         svg: 'assets/fire.svg',
//                         onTap: () {},
//                       ),
//                   options: CarouselOptions(
//                       height: 215.0,
//                       enableInfiniteScroll: false,
//                       initialPage: 0,
//                       enlargeCenterPage: false,
//                       viewportFraction: .85),
//                 ),
//                 // SizedBox(height: 15),
//                 CardTitle(
//                   color: Palette.yellow,
//                   departmanet: "POLICE SERVICES",
//                   svg: "assets/shield-halved-solid.svg",
//                 ),
//                 CarouselSlider.builder(
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, int itemIndex,
//                       int pageViewIndex) =>
//                       CardWidget(
//                         address:
//                         ': 6V4Q+R29, Unnamed Road, Vrundavan Society, Yoginagar Society, Surat, Gujarat 395010',
//                         phoneNumber: '111-222-3333',
//                         stationName: 'Puna gam Fire Station',
//                         stationTitle: 'Puna Gam Fire Station, Puna gam',
//                         color: Palette.yellow,
//                         svg: 'assets/shield-halved-solid.svg',
//                         onTap: () {},
//                       ),
//                   options: CarouselOptions(
//                       height: 215.0,
//                       enableInfiniteScroll: false,
//                       initialPage: 0,
//                       enlargeCenterPage: false,
//                       viewportFraction: 0.85),
//                 ),
//
//                 CardTitle(
//                   color: Palette.card_blue,
//                   departmanet: "HOSPITAL SERVICE",
//                   svg: "assets/heart-pulse.svg",
//                 ),
//                 CarouselSlider.builder(
//                   itemCount: 5,
//                   itemBuilder: (BuildContext context, int itemIndex,
//                       int pageViewIndex) =>
//                       CardWidget(
//                         address:
//                         ': 6V4Q+R29, Unnamed Road, Vrundavan Society, Yoginagar Society, Surat, Gujarat 395010',
//                         phoneNumber: '111-222-3333',
//                         stationName: 'Puna gam Fire Station',
//                         stationTitle: 'Puna Gam Fire Station, Puna gam',
//                         color: Palette.card_blue,
//                         svg: 'assets/heart-pulse.svg',
//                         onTap: () {},
//                       ),
//                   options: CarouselOptions(
//                       height: 215.0,
//                       enableInfiniteScroll: false,
//                       initialPage: 0,
//                       enlargeCenterPage: false,
//                       viewportFraction: 0.85),
//                 ),
//               ],
//             ),
//             const Divider(
//               height: 3,
//               color: Colors.white,
//               indent: 20,
//               endIndent: 20,
//             ),
//             h10,
//             Row(
//
//
//               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 InkWell(
//                   onTap: showDataAlert,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(left: 20),
//                         width: 160,
//                         height: 160,
//                         decoration: ShapeDecoration(
//                           image: const DecorationImage(
//                             image: AssetImage(
//                               "assets/fireImage.jpg",
//                             ),
//                             fit: BoxFit.fill,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 2,
//                               strokeAlign: BorderSide.strokeAlignOutside,
//                               color: Colors.white.withOpacity(0.5),
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                       const Icon(Icons.camera_alt_outlined,
//                           color: Colors.white60, size: 35),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     // width: 160,
//                     height: 160,
//                     child: selectedImages.isEmpty
//                         ? const Center(child: Text('Sorry nothing selected!!'))
//                         : ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: selectedImages.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: EdgeInsets.all(10),
//                           width: 160,
//                           height: 180,
//                           decoration: ShapeDecoration(
//                             image: DecorationImage(
//                               image: FileImage(selectedImages[index]),
//                               fit: BoxFit.fill,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(
//                                 width: 2,
//                                 strokeAlign: BorderSide.strokeAlignOutside,
//                                 color: Colors.white.withOpacity(0.5),
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//
//
//                   ),
//                 ),
//
//               ],
//             ),
//             h10,
//             const Divider(
//               height: 3,
//               color: Colors.white,
//               indent: 20,
//               endIndent: 20,
//             ),
//             h10,
//             const Center(
//               child: Text("DESCRIBE",
//                   style: TextStyle(
//                       decoration: TextDecoration.underline,
//                       color: Palette.commoncolor,
//                       fontFamily: "Gilroy",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24)),
//             ),
//             h5,
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//               child: TextField(
//                 cursorColor: Palette.appbar,
//                 decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: "Type..",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     )),
//                 controller: describeController,
//               ),
//             ),
//             h10,
//             const Divider(
//               height: 3,
//               color: Colors.white,
//               indent: 20,
//               endIndent: 20,
//             ),
//             h10,
//             SizedBox(
//               width: 200,
//               height: 50,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       backgroundColor: Palette.card_blue,
//                       side: const BorderSide(
//                           width: 2, color: Palette.commoncolor)),
//                   onPressed: () {},
//                   child: const Text(
//                     "SEND",
//                     style: TextStyle(fontSize: 20),
//                   )),
//             ),
//             h10,
//
//
//             SizedBox(
//               // width: 160,
//               height: 160,
//               child: selectedImages.isEmpty
//                   ? const Center(child: Text('Sorry nothing selected!!'))
//                   : ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: selectedImages.length,
//                 itemBuilder: (context, index) {
//                   if (isImageOrVideoFile(selectedImages[index].path) == true) {
//                     // photo
//                     return Card(
//                       elevation: 5,
//                       child: Container(
//                         margin: const EdgeInsets.all(10) +
//                             const EdgeInsets.symmetric(
//                                 horizontal: 5),
//                         // height: 200,
//                         child: SizedBox(
//                           child: Image.file(selectedImages[index]),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return InkWell(
//                       onTap: () =>
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute<void>(
//                               builder: (context) {
//                                 return DownloaderPage(
//                                   key: UniqueKey(),
//                                   selectedImages[index],
//                                   isPreview: false,
//                                 );
//                               },
//                             ),
//                           ),
//                       child: Card(
//                         elevation: 5,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Card(
//                               elevation: 5,
//                               margin: const EdgeInsets.all(10),
//                               child: DownloaderPage(
//                                 selectedImages[index],
//                                 isPreview: true,
//                               ),
//                             ),
//                             const Icon(
//                               Icons.play_circle,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                                 },
//               ),
//
//
//             ),
//
//
//
//
//           ]),
//         ),
//       ),
//     );
//   }
//
//   showDataAlert() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   20.0,
//                 ),
//               ),
//             ),
//             contentPadding: const EdgeInsets.only(
//               top: 10.0,
//             ),
//             title: const Center(
//               child: Text(
//                 "Image",
//                 style: TextStyle(fontSize: 24.0),
//               ),
//             ),
//             content: Container(
//               height: 250,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                           pickImageByGallery();
//                         },
//                         child: Image.asset(
//                           "assets/add_image.png",
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                       InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                             pickImageByCamera();
//                           },
//                           child: Image.asset("assets/camera.png",
//                               height: 100, width: 100)),
//                     ],
//                   ),
//                   const Divider(
//                     height: 2,
//                     thickness: 1,
//                     indent: 20,
//                     endIndent: 20,
//                     color: Colors.black,
//                   ),
//                   h10,
//                   const Center(
//                     child: Text(
//                       "Video",
//                       style: TextStyle(
//                           fontSize: 24.0, fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                           pickVideoByGallery();
//                         },
//                         child: Image.asset(
//                           "assets/add_image.png",
//                           width: 100,
//                           height: 100,
//                         ),
//                       ),
//                       InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                             pickVideoByCamera();
//                           },
//                           child: Image.asset("assets/camera.png",
//                               height: 100, width: 100)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   bool? isImageOrVideoFile(String fileName) {
//     final lowerCaseFileName = fileName.toLowerCase();
//
//     final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
//
//     final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];
//
//     final fileExtension = path.extension(lowerCaseFileName);
//
//     if (imageExtensions.contains(fileExtension)) {
//       return true;
//     } else if (videoExtensions.contains(fileExtension)) {
//       return false;
//     } else {
//       return null;
//     }
//   }
//
//   // imageFromGallery() async {
//   //   XFile? pickedFile =
//   //       await ImagePicker().pickImage(source: ImageSource.gallery);
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       imageFile = File(pickedFile.path);
//   //     });
//   //   }
//   // }
//
//   Future pickImageByGallery() async {
//     // final XFile? image = await picker.pickImage(
//     //   source: ImageSource.gallery,
//     // );
//     final pickedFile = await picker.pickMultiImage();
//     List<XFile> xfilePick = pickedFile;
//     if (xfilePick.isNotEmpty) {
//       for (var i = 0; i < xfilePick.length; i++) {
//         selectedImages.add(File(xfilePick[i].path));
//       }
//       print("imgae path == > ${selectedImages[0]}");
//       setState(
//             () {},
//       );
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
//     }
//
//     // if (image != null) {
//     //   setState(() {
//     //     _image = image;
//     //   });
//     // } else {
//     //   print("not pick image");
//     // }
//   }
//
//   Future pickImageByCamera() async {
//     final XFile? pickedFileImage = await picker.pickImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFileImage != null) {
//       selectedImages.add(File(pickedFileImage.path));
//     }
//
//   }
//
//   Future pickVideoByGallery() async {
//     final XFile? pickedFileVideo = await picker.pickVideo(
//         source: ImageSource.gallery);
//     if (pickedFileVideo != null) {
//       selectedImages.add(File(pickedFileVideo.path));
//
//
//
//     }
//   }
//     Future pickVideoByCamera() async {
//       final XFile? pickedFileVideo = await picker.pickVideo(source: ImageSource.camera);
//       if (pickedFileVideo != null) {
//         selectedImages.add(File(pickedFileVideo.path));
//       }
//     }
//
// }
