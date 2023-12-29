import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:rakashkh/provider/authprovider.dart';
import 'package:rakashkh/provider/getAllVehicle.dart';
import 'package:rakashkh/provider/mainScreenProvider.dart';
import 'package:rakashkh/provider/reportProvider.dart';
import 'package:rakashkh/utils/context_ext.dart';
import 'package:stacked_services/stacked_services.dart';

class DisasterApp extends StatefulWidget {
  const DisasterApp({Key? key}) : super(key: key);

  @override
  DisasterAppState createState() => DisasterAppState();
}

class DisasterAppState extends State<DisasterApp> {
  @override
  void initState() {
    super.initState();
    initSetup();
  }

  void initSetup() async {}

  @override
  void dispose() {
    super.dispose();
  }

  Widget myBuilder(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
        ChangeNotifierProvider(create: (context) => GetAllVehicles(),)
      ],
      child: MaterialApp(

        title: "Si Eclipse",
        debugShowCheckedModeBanner: false,
        // theme: Palette.lightTheme,
        // darkTheme: Palette.darkTheme,
        // themeMode: context.watch<ThemeProvider>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: (context, child) {
          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
          child = myBuilder(context, child!); //do something
          child = botToastBuilder(context, child);
          SystemChrome.setSystemUIOverlayStyle(context.isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark);
          return child;
        },
        // onGenerateRoute: AppRoutes.obtainRoute,
        home: const PreLoader(),
      ),
    );
  }
}

class PreLoader extends StatefulWidget {
  const PreLoader({Key? key}) : super(key: key);

  @override
  PreLoaderState createState() => PreLoaderState();
}

class PreLoaderState extends State<PreLoader> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {});
  }

  @override
  Widget build(BuildContext context) {
    return const IntroScreen();
  }
}
