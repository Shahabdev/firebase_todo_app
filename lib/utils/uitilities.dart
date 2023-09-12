import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils
{
  void toastMessage(String message)
  {
    Fluttertoast.showToast(msg: message,
    toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.black54,
      backgroundColor: Colors.blueAccent,
        fontSize: 18.0
    );
  }
}