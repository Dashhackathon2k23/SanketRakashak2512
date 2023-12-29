import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:rakashkh/app/globals.dart';
import 'package:rakashkh/disaster_app.dart';
import 'package:shared_preferences/shared_preferences.dart';


void runAtStartUp() async {
  sharedPref = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const DisasterApp());
}
