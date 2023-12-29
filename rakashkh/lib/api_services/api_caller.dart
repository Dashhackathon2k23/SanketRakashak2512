import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rakashkh/model/signup_model.dart';

final apiCaller = ApiCaller.instance;
class ApiCaller {
  const ApiCaller._();

  static ApiCaller get instance => const ApiCaller._();
  static var header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  Future<SignUpModel?> signUpApi(
      {required String tcName,
        required String mpinValue,
        required String cMpinValue,
        required String tcNumber}) async {
    var map = {
      "name": tcName,
      "MPIN": mpinValue.toString(),
      "MPINConfirm": cMpinValue.toString(),
      "number": "+91$tcNumber",
    };
    var url = Uri.parse("https://rakshak-dev.onrender.com/api/v1/users/signUp");
    var response = await http.post(url, body: jsonEncode(map), headers: header);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    final signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 400) {
      return SignUpModel();
    } else {
      return signUpModel;
    }
  }
  //
  // Future<bool> loginApi({
  //   required String tcNumber,
  //   required String mpinValue,
  // }) async {
  //   Map map = {"number": "+91$tcNumber", "MPIN": mpinValue};
  //
  //   var url = Uri.parse("https://rakshak-dev.onrender.com/api/v1/users/login");
  //   var response = await http.post(url, body: jsonEncode(map), headers: header);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   if (response.statusCode == 400) {
  //     return false;
  //   } else {
  //     signUpModel = SignUpModel.fromJson(jsonDecode(response.body));
  //     notifyListeners();
  //     return true;
  //   }
  // }


}
