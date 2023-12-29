import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/login_model.dart';
import 'package:rakashkh/model/signup_model.dart';
import 'package:rakashkh/screen/address/location_service.dart';

class AuthenticationProvider extends ChangeNotifier {
  SignUpModel? signUpModel;
  LoginModel? loginModel;

  void getUserLocation(UserLocation userLocation){
    userLocationList.add(userLocation);
    notifyListeners();
  }

  var header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<bool> signUpApi(
      {required String tcName,
        required String mpinValue,
        required String cMpinValue,
        required String tcNumber,
        required String token})  async {
    var map = {
      "name": tcName,
      "MPIN": mpinValue.toString(),
      "MPINConfirm": cMpinValue.toString(),
      "number": "+91$tcNumber",
      "fcm_token":token,
    };


    var url = Uri.parse("https://rakshak-backend-dev.onrender.com/api/v1/users/signUp");
    // var url = Uri.parse("https://rakshak-dev.onrender.com/api/v1/users/signUp");
    var response = await http.post(url, body: jsonEncode(map), headers: header);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 400) {
      return false;
    } else {
      signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return true;
    }
  }
  List<UserLocation> userLocationList = [];


  Future<bool> loginApi({
    required String tcNumber,
    required String mpinValue,
    required String fcmToken,
  }) async {
    Map map = {"number": "+91$tcNumber", "MPIN": mpinValue,"fcm_token": fcmToken};

    var url = Uri.parse("https://rakshak-backend-dev.onrender.com/api/v1/users/login");
    var response = await http.post(url, body: jsonEncode(map), headers: header);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 400) {
      return false;
    } else {
      loginModel =LoginModel.fromJson(jsonDecode(response.body));
      // signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      return true;
    }
  }

  // Future<bool> GetAdminData()
  // async {
  //   var url = Uri.parse("https://rakshak-backend-dev.onrender.com/api/v1/users/me");
  //   // var url = Uri.parse("https://rakshak-dev.onrender.com/api/v1/users/signUp");
  //   var response = await http.get(url, headers: header);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }

}
