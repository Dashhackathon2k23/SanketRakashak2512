import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseApi
{
  final _firebasemessi = FirebaseMessaging.instance;
  Future<String> initNotification() async {
    await _firebasemessi.requestPermission();
    final fomToken =await _firebasemessi.getToken();
    print("Token : $fomToken");
    return fomToken!;
  }



}