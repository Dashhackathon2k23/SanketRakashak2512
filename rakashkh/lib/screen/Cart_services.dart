import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/custom_widget/cards.dart';
import 'package:rakashkh/model/nearest_location_data_model.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/screen/Hosptial_service_details.dart';
import 'package:rakashkh/widgets/card_title.dart';

class CartServices extends StatefulWidget {
  bool isColor;
  CartServices({super.key, required this.isColor});
  // const CartServices({super.key});
  @override
  State<CartServices> createState() => _CartServicesState();
}

class _CartServicesState extends State<CartServices> {
  late PageController _pageController;
  late MainScreenProvider mainprovider;
  Departments? fireModel;
  Departments? policeModel;
  Departments? hospitalModel;
  List<Departments> fireModelList = [];
  List<Departments> policeModelList = [];
  List<Departments> hospitalModelList = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
    mainprovider = context.read<MainScreenProvider>();
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mainprovider = context.watch<MainScreenProvider>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardTitle(
                color: Colors.red,
                departmanet: "FIRE SERVICE",
                svg: "assets/fire.svg",
              ),
              CarouselSlider.builder(
                itemCount: fireModelList.length,
                itemBuilder: (BuildContext context, int i, int pageViewIndex) {
                  return fireModelList != null
                      ? CardWidget(
                          address: fireModelList[i].address,
                          // phoneNumber: "${fireModelList[i].number}",
                          phoneNumber:  removeBrackets("${fireModelList[i].number}"),
                          stationName: fireModelList[i].name,
                          color: Palette.colorPrimary,
                          svg: 'assets/fire.svg',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {

                                return HOspitalServiceDetail(fireModelList[i]);
                              },
                            ));
                          },
                          stationTitle: fireModelList[i].name,
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
                          address: policeModelList[i].address,
                          // phoneNumber: "${policeModelList[i].number}",
                          phoneNumber:  removeBrackets("${policeModelList[i].number}"),
                          stationName: policeModelList[i].name,
                          color: Palette.yellow,
                          svg: 'assets/shield-halved-solid.svg',
                          onTap: () {
                            print("police model--> ${policeModelList[0].name}");
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HOspitalServiceDetail(
                                    policeModelList[i]);
                              },
                            ));
                          },
                          stationTitle: policeModelList[i].name,
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
                          address: hospitalModelList[i].address,
                          // phoneNumber: "${hospitalModelList[i].number}",
                          phoneNumber: removeBrackets("${hospitalModelList[i].number}"),
                          stationName: "${hospitalModelList[i].name}",
                          color: Palette.card_blue,
                          svg: "assets/heart-pulse.svg",
                          onTap: () {


                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HOspitalServiceDetail(
                                    hospitalModelList[i]);
                              },
                            ));
                          },
                          stationTitle: hospitalModelList[i].name,
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
            ],
          ),
        ),
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
