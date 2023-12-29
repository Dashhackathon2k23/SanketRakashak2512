import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/assets.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/custom_widget/cards.dart';
import 'package:rakashkh/screen/Cart_services.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/text_widget.dart';

class AddressServicesScreen extends StatefulWidget {
  const AddressServicesScreen({super.key});

  @override
  State<AddressServicesScreen> createState() => _AddressServicesScreenState();
}

class _AddressServicesScreenState extends State<AddressServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.appbar,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
             return Homescreenmap();
           },));
          },
          child: const CircleAvatar(
            radius: 80,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/main button (1).png"),
          )),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: _buildBottomTab(),
      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return AddressServicesScreen();
              },));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              child: Image.asset("assets/search.png", height: 30,),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return AddressServicesScreen();
              },));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              child: Image.asset("assets/search.png", height: 30,),
            ),
          ),

        ],
      ),
      body: Column(
        children: [_tabBar(), h30, Expanded(child: _tabBarView())],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      color: Palette.lightMain,
      child: TabBar(
          indicatorColor: Palette.white,
          indicatorWeight: 3,
          controller: tabController,
          labelStyle:
              const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          tabs: const [
            Tab(
              text: "Address",
            ),
            Tab(
              text: "Services",
            ),
          ]),
    );
  }

  Widget _tabBarView() {
    return TabBarView(
      controller: tabController,
      children: [
        _addressView(),
        CartServices(isColor: true),
      ],
    );
  }



  Widget _addressView() {
    return ListView(
      children: [],
    );
  }

  Widget _fireText() {
    return  Padding(
      padding: EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department_sharp,
            color: Palette.red,
            size: 30,
          ),
          w10,
          Texts(
            "FIRE SERVICES",
            fontWeight: FontWeight.bold,
            color: Palette.redLight,
            fontSize: 19,
          )
        ],
      ),
    );
  }

  Widget _policeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Image.asset(Assets.police),
          w10,
          const Texts(
            "POLICE SERVICES",
            fontWeight: FontWeight.bold,
            color: Palette.yellow,
            fontSize: 19,
          )
        ],
      ),
    );
  }

  Widget _hospitalText() {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Image.asset(Assets.hospital),
          w10,
          const Texts(
            "HOSPITAL SERVICES",
            fontWeight: FontWeight.bold,
            color: Palette.lightBlue,
            fontSize: 19,
          )
        ],
      ),
    );
  }
}
