import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String buttonname;
  // final VoidCallback onTap;
  final IconData icon;

  const RoundButton(
      {super.key,
      required this.buttonname,
      // required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5,),
          Center(

              child: Text(buttonname,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w600
                  ))),
          Center(child: Icon(icon)),
        ],
      ),
    );
  }
}
