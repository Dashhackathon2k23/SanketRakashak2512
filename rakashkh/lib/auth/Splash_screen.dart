import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakashkh/app/Palette.dart';
import 'package:rakashkh/app/dimensions.dart';
import 'package:rakashkh/app/font.dart';
import 'package:rakashkh/auth/login_screen.dart';
import 'package:rakashkh/auth/signup_screen.dart';
import 'package:rakashkh/screen/HomeScreenMap.dart';
import 'package:rakashkh/widgets/base_scaffold.dart';
import 'package:rakashkh/widgets/button_widgets.dart';
import 'package:rakashkh/widgets/text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return BaseScaffold(
      resizeToAvoidBottomInset: false,
      hasAppbar: false,
      hasBack: false,
      backgroundColor: Palette.mainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 170,
          ),
          _headerImage(),
          h50,
          _heading(),
          const SizedBox(
            height: 70,
          ),
          _signUpButton(),
          h20,
          _loginButton(),
          h30,
          _skip()
        ],
      ),
    );
  }

  Widget _headerImage() {
    return SvgPicture.asset(
      "assets/Frame2.svg",
      height: 100,
      width: 100,
    );
  }

  Widget _heading() {
    return const Center(
      child: Texts(
        "DISASTER",
        fontSize: 50,
        fontFamily: Fontes.GilroyBold,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
        color: Palette.white,
      ),
    );
  }

  Widget _signUpButton() {
    return FilledButtons(
      color: const Color(0xff09A789),
      fontSize: 18,
      borderWidth: 2,
      borderRadius: 16,
      applyGradient: true,
      textColor: Palette.white,
      fontWeight: FontWeight.bold,
      fontFamily: Fontes.GilroyRegular,
      height: 55,
      width: 271,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const SignUPScreen();
          },
        ));
      },
      text: 'SIGN UP',
    );
  }

  Widget _loginButton() {
    return FilledButtons(
      borderWidth: 2,
      color: const Color(0xff09A789),
      fontSize: 18,
      borderRadius: 16,
      applyGradient: true,
      textColor: Palette.white,
      fontWeight: FontWeight.bold,
      fontFamily: Fontes.GilroyRegular,
      height: 55,
      width: 271,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ));
      },
      text: 'LOGIN',
    );
  }

  Widget _skip() {
    return FilledButtons(
      height: 35,
      width: 175,
      borderRadius: 16,
      // borderWidth: 0.5,
      borderWidth: 1,
      borderSideColor: Palette.white,
      fontWeight: FontWeight.w500,
      fontFamily: Fontes.GilroyRegular,

      color: Colors.transparent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Homescreenmap();
          },
        ));
      },
      text: 'skip',
    );
  }
}
