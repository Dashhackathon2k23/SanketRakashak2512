import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rakashkh/model/Oprationreport.dart';

class ReportProvider extends ChangeNotifier {
  var dio = Dio();
  OperationReport? operationReport;



  Future<bool> ReportDioApi(
    File selectedImag,
    List<double> location,
    String usernumber,
    List<String> departmentSid,
    String description, String deptid,
  ) async {
    String ALldepartmentid = concatenateList(departmentSid);
    print(ALldepartmentid);



    if (selectedImag != null && await selectedImag.exists()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://rakshak-backend-dev.onrender.com/api/v1/operation'),
        // Uri.parse('https://f14f-150-107-232-255.ngrok-free.app/api/v1/operation'),
      );

      request.fields.addAll({
        // 'data' : map.toString(),

        'data':'{"location": {"type": "Point","coordinates": $location},"description": "$description","number": "$usernumber","department": "$ALldepartmentid" }',
      });
      request.files
          .add(await http.MultipartFile.fromPath('file', selectedImag.path));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        notifyListeners();

        return true;
      } else {
        print(response.reasonPhrase);
        return true;
      }

    } else {
      print('Selected image does not exist');
      return true;
    }


  }
  String concatenateList(List<String> inputList) {
    return inputList.join('::');
  }
}
