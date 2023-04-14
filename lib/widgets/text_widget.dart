// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class myText extends StatelessWidget {
  String text;
  FontWeight? fontWeight;
  String fontFamily;
  double size;
  Color color;
  TextDecoration? textDecoration;
  TextAlign? textAlign;
  myText({Key? key,this.textDecoration,this.fontWeight,this.textAlign,required this.text,required this.fontFamily,required this.size,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        color: color,
        fontWeight: fontWeight??FontWeight.w300,
        decoration: textDecoration??TextDecoration.none
      ),
      textAlign: textAlign,
    );
  }
}
