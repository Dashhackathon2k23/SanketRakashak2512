import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/auth/otp_screen.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:rakashkh/widgets/text_field_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';


class mobileNumberScreen extends StatefulWidget {
  final String contactNumber;

  const mobileNumberScreen(this.contactNumber, {Key? key}) : super(key: key);
  static String verifications = "";

  @override
  State<mobileNumberScreen> createState() => _mobileNumberScreenState();
}

class _mobileNumberScreenState extends State<mobileNumberScreen> {
  final tcPhone = TextEditingController();

  // TextEditingController phoneNumber = TextEditingController();
  bool isLoading = false;
  bool isChnageNumber = true;

  String vid = "";
  String countrycode = "";

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      tcPhone.text = widget.contactNumber;
    });
    autofill();
    super.initState();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double heightt = MediaQuery.of(context).size.height;
    double keboardheight = MediaQuery.of(context).viewInsets.bottom;
    double height = heightt - keboardheight;

    return BaseScaffold(
      hasAppbar: false,
      hasBack: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.mainColor,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _headingText(),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const Text(
              "We need to register your phone before getting started!",
              style: TextStyle(fontSize: 16, color: Palette.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          _numberTextField(),
          h10,
          _chnageNumber(),
          const SizedBox(
            height: 15,
          ),
          _sendOtp(),
        ]),
      ),
    );
  }

  Widget _headingText() {
    return const Text(
      " Mobile Number Verification",
      style: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w500, color: Palette.white),
    );
  }

  Widget _numberTextField() {
    return SizedBox(
      width: screenWidth,
      child: TextFormFieldWidget(
        controller: tcPhone,
        filled: true,
        readOnly: isChnageNumber,
        textAlign: TextAlign.center,
        filledColor: Colors.white38,
        textInputType: TextInputType.number,
        hintText: "Enter Your Number",
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 17),
        style: const TextStyle(color: Colors.black45, fontSize: 20),
        maxLength: 10,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter a phone number";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _chnageNumber() {
    return InkWell(
      onTap: () {
        setState(() {
          isChnageNumber = false;
        });
      },
      child: const Text(
        "Change Number ?",
        style: TextStyle(fontSize: 15, color: Palette.white),
      ),
    );
  }

  Widget _sendOtp() {
    return FilledButtons(
      isLoading: isLoading,
      color: const Color(0xff09A789),
      fontSize: 18,
      applyGradient: true,
      textColor: Palette.white,
      fontWeight: FontWeight.bold,
      height: 55,
      width: screenWidth,
      onTap: () async {
        setState(() {
          isLoading = true;
        });


        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91 ${tcPhone.text}",
          verificationCompleted: (_) {
            setState(() {
              isLoading = false;
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Verification Failed! Try after some time.")));
            setState(() {
              isLoading = false;
            });
          },
          codeSent: (String verificationId, int? resendToken) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return OtpScreen(
                  verificationId: verificationId,
                );
              },
            ));
            setState(() {
              isLoading = false;
            });
          },
          codeAutoRetrievalTimeout: (e) {
            setState(() {
              isLoading = false;
            });
          },
        );
      },
      text: 'Send Otp',
    );
  }
  Future<void> autofill()
  async {
    var appSignatureid = await SmsAutoFill().getAppSignature;
    print("AppsignatureId == > ${appSignatureid}");
    Map sendotpData = {
      "mobile_number":tcPhone.text,
      "app_signature_id":appSignatureid,
    };
  }
}
