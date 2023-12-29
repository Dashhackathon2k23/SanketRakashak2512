import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rakashkh/api_services/Firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:easy_localization/easy_localization.dart';

import 'firebase_options.dart';
import 'root_setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();
  GetIt.I.registerSingletonAsync<SharedPreferences>(() =>SharedPreferences.getInstance() );

  await FirebaseApi().initNotification();

  runAtStartUp();

}
