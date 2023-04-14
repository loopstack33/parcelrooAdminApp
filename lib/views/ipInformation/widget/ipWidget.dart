import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../enums/color_constants.dart';

class IPWidget extends StatelessWidget {
  final String ip;
  final String dateTime;
  final String city;
  final String country;
  const IPWidget({Key? key,required this.ip,required this.dateTime,required this.country,required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      padding: const EdgeInsets.all(10),
      margin:const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5)
          ]),
      child:  Text.rich(
        TextSpan(
          children: [
            const TextSpan(
                text:
                'Your account was successfully logged in from IP ',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins')),
            TextSpan(
                text:
                '$ip  ',
                style: const TextStyle(
                    fontSize: 14,
                    color: dashColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600)),
            const TextSpan(
                text:
                'At ',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins')),
            TextSpan(
                text: DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateTime))).toString(),
                style: const TextStyle(
                    fontSize: 14,
                    color: dashColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600)),
            const TextSpan(
                text: " in ",
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins')),
            TextSpan(
                text: "$city, $country",
                style: const TextStyle(
                    fontSize: 14,
                    color:dashColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
