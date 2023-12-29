import 'package:flutter/material.dart';
import 'package:rakashkh/AdminPanel/Add_service.dart';
import 'package:rakashkh/AdminPanel/service_details.dart';
import 'package:rakashkh/custom_widget/TabItem.dart';

import '../app/Palette.dart';

class Service_Page extends StatefulWidget {
  const Service_Page({super.key});

  @override
  State<Service_Page> createState() => _Service_PageState();
}

class _Service_PageState extends State<Service_Page> {
  int currentIndex = 0;
  final List<Widget> screen = [const serviceDetail(),const  AddService()];
  final tab = ["Find", "Service"];

  @override
  TabBar get _tabBar => const TabBar(
        indicatorColor: Palette.appbar,
        tabs: [
          Tab(
              child: TextButton(
                  onPressed: null,
                  child: Text(
                    "Details",
                    style: TextStyle(color: Palette.commoncolor, fontSize: 16),
                  ))),
          Tab(
              child: TextButton(
                  onPressed: null,
                  child: Text(
                    "Add",
                    style: TextStyle(color: Palette.commoncolor, fontSize: 16),
                  ))),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/main button1.png"),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomTab(),
        appBar: AppBar(
          title: const Center(
            child: Text("Service"),
          ),
          backgroundColor: Palette.appbar,
          actions: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              child: const Icon(Icons.translate),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(color: Palette.subappbar, child: _tabBar),
          ),
        ),

        body: const TabBarView(children: [serviceDetail(), AddService()]),
      ),
    );
  }

  _buildBottomTab() {
    return BottomAppBar(
      color: Palette.commoncolor,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TabItem(
            tab[0],
            onTap: () {},
            image: 'assets/search.png',
          ),
          const SizedBox(
            width: 25,
          ),
          TabItem(
            tab[1],
            onTap: () {},
            image: 'assets/compass.png',
          ),
        ],
      ),
    );
  }
}
