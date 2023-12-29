import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rakashkh/TimeHoldOut/hold_timeout_detector.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/helper/Common_helper.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/screen/Report_screen.dart';
import 'package:rakashkh/screen/adrress&service_screen.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/lazy_indexed_stack/lazy_load_indexed_stack.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  List screenList = [
    const AddressServicesScreen(),
    Homescreenmap(),
    const AddressServicesScreen(),
  ];
  int selectedIndex = 1;
  Timer? timer;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: screenList[selectedIndex],
          ),
          Container(
            height: 110,

            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(250),
                                bottomLeft: Radius.circular(250),
                              ),
                              onTap: () {
                                selectedIndex = 0;
                                setState(() {});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      // margin: const EdgeInsets.only(
                                      //     right: 15, top: 10),
                                      height: 28,
                                      child: Image.asset("assets/compass.png")),
                                  const Text(
                                    "Services",
                                    style:
                                    TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            child: InkWell(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(250),
                                bottomRight: Radius.circular(250),
                              ),
                              onTap: () {
                                selectedIndex = 2;
                                setState(() {});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      // margin: const EdgeInsets.only(
                                      //     right: 15, top: 10),
                                      height: 30,
                                      child: Image.asset("assets/search.png")),
                                  Text(
                                    "Find".trim(),
                                    style:
                                    const TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: HoldTimeoutDetector(
                    onCancel: () {
                      timer?.cancel();
                      CommonHelper().ShowToast(
                          message: "Please Hold out 3 second for reporting",
                          color: Colors.black);
                    },
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    onTimeout: () {},
                    onTimerInitiated: () {
                      timer = Timer(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const ReportScreen();
                          },
                        ));
                      });
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(250)),
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/main button (1).png",
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
