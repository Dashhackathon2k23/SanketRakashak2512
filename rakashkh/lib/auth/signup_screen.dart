import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/app/font.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/auth/mobile_number_screen.dart';
import 'package:rakashkh/model/signup_model.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:rakashkh/widgets/text_field_widget.dart';
import 'package:rakashkh/widgets/text_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({super.key});

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  final tcNumber = TextEditingController();
  final tcName = TextEditingController();
  final pinController = TextEditingController();
  final cPinController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String mpinValue = "";
  String cMpinValue = "";
  SignUpModel? model;
  late AuthenticationProvider authProvider;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider = context.read<AuthenticationProvider>();
    // autofill();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthenticationProvider>();
    return BaseScaffold(
        hasBack: true,
        hasAppbar: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Palette.mainColor,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              _signUpText(),
              const SizedBox(
                height: 50,
              ),
              _nameTextField(),
              h20,
              _numberTextField(),
              h30,
              _mPinText(),
              h10,
              _mPin(),
              h30,
              _confirmMpinText(),
              h10,
              _confirmMPin(),
              const SizedBox(
                height: 50,
              ),
              _signUpButton(),
            ],
          ),
        ));
  }

  Widget _signUpText() {
    return const Center(
      child: Texts(
        "SIGN UP",
        fontSize: 50,
        fontWeight: FontWeight.w700,
        fontFamily: Fontes.GilroyBold,
        textAlign: TextAlign.center,
        color: Palette.white,
      ),
    );
  }

  Widget _nameTextField() {
    return SizedBox(
      width: 330,
      child: TextFormFieldWidget(
        controller: tcName,
        filled: true,
        textAlign: TextAlign.center,
        filledColor: Colors.white38,
        textInputType: TextInputType.text,
        hintText: "Enter Your Name",
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 17),
        style: const TextStyle(color: Colors.black45, fontSize: 20),
        // maxLength: 10,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter your Name";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _numberTextField() {
    return SizedBox(
      width: 330,
      child: TextFormFieldWidget(
        controller: tcNumber,
        filled: true,
        textAlign: TextAlign.center,
        filledColor: Colors.white38,
        textInputType: TextInputType.number,
        hintText: "Enter Your Number",
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 17),
        style: const TextStyle(color: Colors.black45, fontSize: 20),
        maxLength: 10,
        validator: (value) {
          if (value!.isEmpty) {
            return "ENTER A PHONE NUMBER";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _mPinText() {
    return const Center(
      child: Texts(
        "MPIN",
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Palette.white,
      ),
    );
  }

  Widget _mPin() {
    return Pinput(
      length: 4,
      forceErrorState: true,
      controller: pinController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter a MPin";
        } else {
          return null;
        }
      },
      onCompleted: (value) {
        setState(() {
          mpinValue = value;
        });
      },
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.black45, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            color: Palette.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _confirmMpinText() {
    return const Center(
      child: Texts(
        " Confirm MPIN",
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: Palette.white,
      ),
    );
  }

  Widget _confirmMPin() {
    return Pinput(
      length: 4,
      forceErrorState: true,
      controller: cPinController,
      obscureText: true,

      validator: (value) {
        if (value!.isEmpty) {
          return "Enter a MPin";
        } else {
          return null;
        }
      },
      onCompleted: (value) {
        setState(() {
          cMpinValue = value;
        });
      },
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.black45, fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Palette.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return FilledButtons(
      isLoading: isLoading,
      color: const Color(0xff09A789),
      fontSize: 18,
      applyGradient: true,
      borderWidth: 2,
      borderRadius: 16,
      textColor: Palette.white,
      fontWeight: FontWeight.bold,
      height: 55,
      width: 271,
      onTap: () async {
        if (formKey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          final token= await FirebaseMessaging.instance.getToken();
          print("hpp token=${token.toString()}");
          authProvider
              .signUpApi(
                  tcName: tcName.text,
                  mpinValue: mpinValue,
                  cMpinValue: cMpinValue,
                  tcNumber: tcNumber.text,
              token:token.toString() )
              .then((value) {
            print("value$value");
            if (value) {
              IntroScreen.token = authProvider.signUpModel!.data!.token!;
              // setState(() {});
              setState(() {
                isLoading = false;
              });
              IntroScreen.pref!.setString("token", IntroScreen.token);

              IntroScreen.pref!.setString("UserNumber", IntroScreen.userNumber);
              // IntroScreen.pref!.setBool("loginOrSignup", true);
              if (authProvider.signUpModel!.success == "Success") {
                setState(() {
                  isLoading = false;
                });
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return mobileNumberScreen(tcNumber.text);
                    // return Homescreenmap();
                  },
                ));
              }
            } else {
              setState(() {
                isLoading = true;
              });
              print("invalid data");
            }
          });
        } else {
          print("inavlid data");
        }
      },
      text: 'SIGN UP',
    );
  }

  void getprefrences() {
    setState(() {
      IntroScreen.token = IntroScreen.pref!.getString("token") ?? "";
    });
  }

}
