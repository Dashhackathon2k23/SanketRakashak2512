import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rakashkh/auth/intro_screen.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/GetAllVehicle.dart';

class GetAllVehicles extends ChangeNotifier
{

  GetAllVehicle? getAllVehicle;
  Future<void> GetVehicle ()
  async { var header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${IntroScreen.pref!.getString("Logintoken")}',
  };

  var url = Uri.parse('https://rakshak-backend-dev.onrender.com/api/v1/vehicle');
  var response = await http.get(url, headers: header);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');


   getAllVehicle = GetAllVehicle.fromJson(jsonDecode(response.body));
  // print(" vehicle name === >${getAllVehicle!.data![0].name}");

  notifyListeners();

  }
}