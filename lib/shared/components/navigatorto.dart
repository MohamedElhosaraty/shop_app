import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo (context ,widget) =>
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => widget,),);



void navigateAndFinish (context ,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder:(context) => widget,
    ), (route) => false);


void showToast ({required String message , required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 20.0
  );
}

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseColor (ToastStates state) {
  Color color ;
  switch(state){
    case  ToastStates.SUCCESS : return  color =Colors.green;

    case ToastStates.ERROR:return color = Colors.red;

    case ToastStates.WARNING:return color = Colors.amber;
  }
}

void printFullText (String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print (match.group(0)));
}