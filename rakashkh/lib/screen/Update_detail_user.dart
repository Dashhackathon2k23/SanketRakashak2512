import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/screen/Settings_With_Destination.dart';
import 'package:rakashkh/widgets/button_widgets.dart';

class UpdateUserDetail extends StatefulWidget {
  String username;
  String usernumber;

  UpdateUserDetail(this.username, this.usernumber);

  @override
  State<UpdateUserDetail> createState() => _UpdateUserDetailState();
}

class _UpdateUserDetailState extends State<UpdateUserDetail> {
  TextEditingController userName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName.text = widget.username;
    contactNumber.text = widget.usernumber;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
      body: Column(
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
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: userName,
              cursorColor: Palette.appbar,
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.subappbar)),
                  icon: Icon(Icons.maps_home_work_outlined,
                      color: Palette.subappbar),
                  hintText: "Enter Your Name",
                  hintStyle: TextStyle(
                    fontFamily: "Gilroy",
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: contactNumber,
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
          h10,
          FilledButtons(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SettingWithDestinationScreen();
                  },
                ));
              },
              text: "Submit",
              color: Palette.appbar,
              width: 204,
              height: 50,
              borderRadius: 25),


        ],
      ),
    ));
  }
}
