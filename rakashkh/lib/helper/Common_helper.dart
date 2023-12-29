import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';

class CommonHelper extends ChangeNotifier{

  void ShowToast({required String message , required Color color}){
    BotToast.showText(text: message, contentColor: color);
  }
}