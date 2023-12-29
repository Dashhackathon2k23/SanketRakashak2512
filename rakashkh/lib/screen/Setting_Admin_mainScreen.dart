import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/widgets/button_widgets.dart';

class SettingAdminBasicScreen extends StatefulWidget {
  const SettingAdminBasicScreen({super.key});

  @override
  State<SettingAdminBasicScreen> createState() => _SettingAdminMainScreenState();
}

class _SettingAdminMainScreenState extends State<SettingAdminBasicScreen> {
  TextEditingController officerName = TextEditingController();
  TextEditingController officerNumber = TextEditingController();
  String selectedDesignation = 'Chief Fire Officer';
  List<String> designation = ["Chief Fire Officer", "Fire Workers"];


  @override
  Widget build(BuildContext context) {

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
                  controller: officerName,
                  cursorColor: Palette.appbar,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Palette.subappbar)),
                      icon: Icon(Icons.person_2_outlined,
                          color: Palette.subappbar),
                      hintText: "Enter Officer Name",
                      hintStyle: TextStyle(
                        fontFamily: "Gilroy",
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: officerNumber,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  w10,w10,w5,
                  const Icon(
                    Icons.car_crash_outlined,
                    color: Palette.subappbar,
                  ),
                  Container(

                    // padding: const EdgeInsets.all(10),
                    height: 45,
                    width: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        border: Border.all(color: Colors.black)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
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

                ],
              ),
              h10,
              FilledButtons(
                  onTap: () {

                  },
                  text: "Submit",
                  color: Palette.appbar,
                  width: 204,
                  height: 50,
                  borderRadius: 25),
            ],
          ),
        ),


      ),
    );
  }
}
