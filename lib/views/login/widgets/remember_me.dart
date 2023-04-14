// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../../../enums/color_constants.dart';

Widget rememberMeCheckbox(bool _rememberMe,
    void Function(bool?) handleRememberMe, BuildContext context) {
  return Row(
    children: <Widget>[
      Container(
        width: 18,
        height:18,
        decoration: BoxDecoration(
            color: lightGrey, borderRadius: BorderRadius.circular(3)),
        child: Theme(
          data: ThemeData(unselectedWidgetColor: lightGrey),
          child: Transform.scale(
            scale:1.0,
            child: Checkbox(
                value: _rememberMe,
                activeColor: darkPurple,
                onChanged: handleRememberMe),
          ),
        ),
      ),
      const SizedBox(width: 10),
      const Text(
        'Remember me!',
        style: TextStyle(fontSize: 16,fontFamily: "Poppins", color: greyLight),
      ),
    ],
  );
}
