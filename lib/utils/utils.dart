
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message,
    backgroundColor: Colors.pink,
    textColor: Colors.orange,
    toastLength: Toast.LENGTH_SHORT);
  }

  static  flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          padding: EdgeInsets.all(15),
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          borderRadius: BorderRadius.circular(8),
          icon: Icon(Icons.error,size: 20,color: Colors.white,),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: Colors.red,
          titleText: Text("FlushBar"),
          messageColor: Colors.lightGreen,
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message),backgroundColor: Colors.green,)
    );
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static void fieldFocusChange(
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus
      ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}