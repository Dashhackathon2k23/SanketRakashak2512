import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/nearest_location_data_model.dart';

class MainScreenProvider extends ChangeNotifier {
  var hospitalDataList = [];
  var fireList = [];
  var policeList = [];

  //DEPARTMENT LOcation
  var firedepartmentLocationList = [];
  var policedepartmentLocationList = [];
  var hospitaldepartmentLocationList = [];

  NearestLocationDataModel? nearestLocationDataModel;

  Future<void> getNearestLoaction(
      {required double latitude, required double longitude}) async {

    var url = Uri.parse(
        // "https://rakshak-dev.onrender.com/api/v1/organization/nearest-organization/$latitude,$longitude");
        "https://rakshak-backend-dev.onrender.com/api/v1/organization/nearest-organization/$latitude,$longitude");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('get nearest location: ${response.body}');
    nearestLocationDataModel =
        NearestLocationDataModel.fromJson(jsonDecode(response.body));
    if (nearestLocationDataModel != null) {
      for (var x in nearestLocationDataModel!.data!.department!) {
        if (x.type!.toLowerCase() == "hospital") {
          print(">>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            hospitalDataList.add(dep);
          }
        }
        if (x.type!.toLowerCase() == "fire") {
          print(">>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            fireList.add(dep);
          }
        }
        if (x.type!.toLowerCase() == "police") {
          print(">>>>>${x.departments.runtimeType}");
          for (final dep in x.departments!) {
            policeList.add(dep);
          }
        }
      }
      for (var x in nearestLocationDataModel!.data!.departmentLocation!) {
     if(x.type=="Fire"){
       firedepartmentLocationList.add(x);
     }
     if(x.type=="Hospital"){
       hospitaldepartmentLocationList.add(x);

     }
     if(x.type=="Police"){
       policedepartmentLocationList.add(x);
     }
      }
    }
    notifyListeners();


  }
}
