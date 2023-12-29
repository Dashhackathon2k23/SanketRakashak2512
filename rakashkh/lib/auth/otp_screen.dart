import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/auth/mobile_number_screen.dart';
import 'package:rakashkh/auth/signup_screen.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({super.key, required this.verificationId,}) ;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  String otp = "";


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // listenotp();
  // }
  @override
  void initState() {
    _listenSmsCode();
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("Unregistered Listener");
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  String otpCode = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return BaseScaffold(
      hasAppbar: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.mainColor,
      child: Container(
        margin:const  EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "  Mobile Number Verification",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Palette.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text(
              "We need to register your phone before getting started!",
              style: TextStyle(fontSize: 16,  color: Palette.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Pinput(
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            length: 6,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onChanged: (value) {
              setState(() {
                otp = value;
              });
            },
          ),
         const  SizedBox(
            height: 25,
          ),
          PinFieldAutoFill(
            currentCode: otp,
            autoFocus: true,
            decoration: BoxLooseDecoration(
                radius: const Radius.circular(12),
                strokeColorBuilder: const FixedColorBuilder(
                    Color(0xFF8C4A52))),
            codeLength: 6,
            onCodeChanged: (code) {
              print("OnCodeChanged : $code");
              otp = code.toString();
            },
            onCodeSubmitted: (val) {
              print("OnCodeSubmitted : $val");
            },
          ),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff09A789),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async {
                  setState(() {
                    isLoading= true;
                  });
                  final crendital = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode:otp);
                  try{
                    IntroScreen.pref!.setBool("loginOrSignup", true);
                    await auth.signInWithCredential(crendital);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Homescreenmap();
                    },));
                  }
                  catch(e)
                  {
                    print(" error ==>${e.toString()}");
                    setState(() {
                      isLoading= false;
                    });

                  }
                },
                // onPressed: () async {
                //
                //   try {
                //     setState(() {
                //       isLoading= true;
                //     });
                //     final crendital = PhoneAuthProvider.credential(
                //         verificationId: widget.verificationId,
                //         smsCode: phoneNumber.text.toString());
                //     try{
                //       await auth.signInWithCredential(crendital);
                //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         return Homescreenmap();
                //       },));
                //     }
                //     catch(e)
                //     {
                //       setState(() {
                //         isLoading= false;
                //       });
                //
                //     }
                //     // FirebaseAuth auth = FirebaseAuth.instance;
                //     //
                //     // PhoneAuthCredential credential =
                //     // PhoneAuthProvider.credential(
                //     //     verificationId: mobileNumberScreen.verifications, smsCode: otp);
                //     //
                //     // // Sign the user in (or link) with the credential
                //     // await auth.signInWithCredential(credential);
                //     // Navigator.pushReplacement(context, MaterialPageRoute(
                //     //   builder: (context) {
                //     //     return SignUPScreen();
                //     //   },
                //     // ));
                //   }
                //   catch (e) {
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text(
                //         "Wrong otp",
                //         style: TextStyle(fontSize: 15),
                //       ),
                //       backgroundColor: Colors.white,
                //       behavior: SnackBarBehavior.floating,
                //       margin: EdgeInsets.only(bottom: 450, right: 100, left: 100),
                //       elevation: 50,
                //       showCloseIcon: true,
                //       duration: Duration(seconds: 2),
                //       animation: Animation.fromValueListenable(CurvedAnimation(
                //           parent: kAlwaysCompleteAnimation,
                //           curve: Curves.easeInOutCubicEmphasized)),
                //     )
                //
                //     );
                //   }
                // },
                child:const  Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                )),
          )
        ]),
      ),
    );
  }

  // Future<void> listenotp() async {
  //   await SmsAutoFill().listenForCode;
  //   print("otp lissten called");
  // }
}
