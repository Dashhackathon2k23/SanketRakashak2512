import 'package:flutter/material.dart';
import 'package:rakashkh/app/Palette.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {

  List<String> designation = ["Chief Fire Officer", "Fire Workers"];
  String selectedDesignation = 'Chief Fire Officer';
  TextEditingController name = TextEditingController();
  TextEditingController contactNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: name,
                cursorColor: Palette.appbar,
                decoration:  const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon:
                        Icon(Icons.person_2_outlined, color: Palette.subappbar),
                    hintText: "Enter Name",
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
                decoration:  const InputDecoration(

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.subappbar)),
                    icon: Icon(Icons.call_outlined, color: Palette.subappbar),
                    hintText: "Enter phone number",
                    hintStyle: TextStyle(
                      fontFamily: "Gilroy",
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.cases_outlined, color: Palette.subappbar),
                SizedBox(

                  width: 300,
                  height: 50,
                  child: DropdownButton(

                    value: selectedDesignation,
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
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
                onPressed: () {
                  // print("Submit value ==>  ${name.text} ${contactNumber.text} ${selectedDesignation } ");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Palette.subappbar,
                    fixedSize: const Size(180, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Gilroy",
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
