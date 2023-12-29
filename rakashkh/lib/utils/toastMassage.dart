import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastMassage
{
  void toastMeassage(String meassage)
  {
    Fluttertoast.showToast(
        msg: meassage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
