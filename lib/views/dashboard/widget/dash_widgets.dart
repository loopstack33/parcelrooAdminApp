// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parcelroo_admin/enums/color_constants.dart';

class DashboardWidget extends StatelessWidget {
  Color boxColor;
  String total;
  String type;
  IconData iconData;

  DashboardWidget({Key? key,required this.iconData,required this.boxColor,required this.total,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: boxColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(iconData,color: dashColor,size: 30),
                Text(total,style: const TextStyle(fontFamily: "Poppins",fontSize: 28,color: dashColor,fontWeight: FontWeight.w600))
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width*0.7,
                child: Text(type,style: const TextStyle(fontSize: 15,fontFamily: "Poppins",color: dashColor,fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}
