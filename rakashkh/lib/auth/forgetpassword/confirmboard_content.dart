import 'package:flutter/material.dart';

class ConfirmBoard extends StatelessWidget {
  const ConfirmBoard({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reset Password",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Set the new password for your account so \nYou can login and access all the features.",
            style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Password",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 70,
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,

              decoration: InputDecoration(
                  hintText: "Enter Your password",

                  hintStyle: TextStyle(color: Colors.blueGrey.shade300,fontSize: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              controller: password,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Re-Enter Password",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 70,
            child: TextFormField(
              obscureText: true,
              maxLength: 4,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(

                  hintText: "Re-Enter Your password",
                  hintStyle: TextStyle(color: Colors.blueGrey.shade300),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              controller: confirmPassword,
            ),
          ),
        ],
      ),
    );
  }
}
