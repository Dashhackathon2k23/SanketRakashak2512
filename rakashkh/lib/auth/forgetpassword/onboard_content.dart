import 'package:flutter/material.dart';
import 'package:rakashkh/auth/forgetpassword/SignUPForm.dart';
import 'package:rakashkh/auth/forgetpassword/confirmboard_content.dart';
import 'package:rakashkh/auth/forgetpassword/landed_content.dart';


class OnboardContent extends StatefulWidget {
  static TextEditingController userNumber = TextEditingController();
  const OnboardContent({super.key});

  @override
  State<OnboardContent> createState() => _OnboardContentState();
}

class _OnboardContentState extends State<OnboardContent> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double progress =
    _pageController.hasClients ? (_pageController.page ?? 0) : 0;
print("progress == > ${progress}");

    return SizedBox(
      //( progress<=1)?progress:progress>1?0: 0
      height: 400 + (progress<=1?progress*30:progress * 60),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children:  [
                    LandingContent(),
                    SignUpForm(),
                    ConfirmBoard(),

                  ],
                ),
              ),
            ],
          ),
          Positioned(
            height: 56,
            // bottom: 48 + progress * 80, ( progress<=1)?progress:progress>1?0: 0
            bottom: 48 + (progress<=1 ?progress*50:0),
            right: 16,
            child: GestureDetector(
              onTap: () {
                if (_pageController.page == 0) {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => SignUpForm(),
                  //   ),
                  // );
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                }
                if (_pageController.page == 1) {
                  _pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease);
                }

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.8],
                    colors: [
                      Color.fromARGB(255, 239, 104, 80),
                      Color.fromARGB(255, 139, 33, 146)
                    ],
                  ),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 92 + progress * 30,
                        child: Stack(
                          fit: StackFit.passthrough,
                          children: [
                            FadeTransition(


                              opacity: AlwaysStoppedAnimation(1 - progress),
                              child: const Text("Get Started"),
                            ),
                            FadeTransition(
                              opacity: AlwaysStoppedAnimation(( progress<=1)?progress:progress>1?0: 0),
                              child: const Text(
                                "Continue",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                            FadeTransition(
                              opacity: AlwaysStoppedAnimation((progress -1)),
                              child: const Text(
                                "Reset Password",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}