import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBest extends StatelessWidget {
  TextBest(
      {super.key,
        required this.text,
        this.color = Colors.black,
        this.textAlign,
        this.fontFamily,
        this.fontWeight = FontWeight.bold,
        this.fontSize = 20,});

  String text;
  TextAlign? textAlign;
  String? fontFamily;

  double fontSize = 20.sp;
  FontWeight fontWeight = FontWeight.bold;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,textAlign: textAlign,
      style:
      TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,fontFamily:fontFamily ),
    );
  }
}