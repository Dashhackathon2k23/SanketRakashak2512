import 'package:flutter/material.dart';
import 'package:rakashkh/auth/forgetpassword/onboard_content.dart';

class LandingContent extends StatelessWidget {
  const LandingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userNumber = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forgot Password",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Enter your Number for the verfication process,\nWe will send 6 digitis code to your phone.",
            style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Phone Number",
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 55,
            child: TextFormField(

              keyboardType: TextInputType.number,
              decoration: InputDecoration(
             hintText: "Enter your Phone Number",
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              controller: OnboardContent.userNumber,
            ),
          ),
        ],
      ),
    );
  }
}
