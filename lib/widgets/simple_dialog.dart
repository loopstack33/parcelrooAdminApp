// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parcelroo_admin/widgets/text_widget.dart';

import '../enums/color_constants.dart';
import '../utils/app_routes.dart';


class MySimpleDialog extends StatelessWidget {
  final String title;
  final String msg;
  final IconData icon;
  const MySimpleDialog({Key? key,required this.title,required this.msg,required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 10,
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: dialogColor,
        child:Container(

          width: MediaQuery.of(context).size.width*0.8,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            boxShadow: const [
              BoxShadow(
                color: Color(0x192f80ed),
                blurRadius: 40,
                offset: Offset(5, 5),
              ),
            ],
            color: dialogColor
          ),
          padding:const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    AppRoutes.pop(context);
                  },
                  child:const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.close_rounded,color: whiteColor,)
                  ),
                ),
                Icon(icon,color: whiteColor,size: 35),
                myText(text: title, fontFamily: "Poppins", fontWeight: FontWeight.w700,size: 24, color: whiteColor,textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                myText(text: msg, fontFamily: "Poppins", fontWeight: FontWeight.w400,size: 16, color: whiteColor,textAlign: TextAlign.center,),

              ],
            ),
          ),
        )
    );
  }

}
