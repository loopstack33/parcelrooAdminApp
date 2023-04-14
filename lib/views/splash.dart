// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/color_constants.dart';
import '../enums/image_constants.dart';
import '../utils/app_routes.dart';
import '../widgets/text_widget.dart';
import 'dashboard/controller/dash_controller.dart';
import 'dashboard/dashboard_screen.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkIfUserLoggedIn();
  }

  checkIfUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loggedIn = prefs.getBool('remember_me');
    var isLoggedIn = prefs.getBool("isLoggedIn");

    log("REMEMBER ME ----- $loggedIn");
    log("IS LOGGED ----- $isLoggedIn");

    if (loggedIn == false && isLoggedIn == false) {

      Future.delayed(const Duration(seconds: 2),
              () => AppRoutes.pushAndRemoveUntil(context, const LoginScreen()));
    }

    else if (loggedIn == true && isLoggedIn == true ) {
      Provider.of<DashController>(context, listen: false).getUserData();
      Future.delayed(const Duration(seconds: 2),
              () => AppRoutes.pushAndRemoveUntil(context, const Dashboard(firstTime:false)));

    }
    else{
      Future.delayed(const Duration(seconds: 2),
              () => AppRoutes.pushAndRemoveUntil(context, const LoginScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text.rich(TextSpan(children:[
                      TextSpan(
                          text: "Parcel",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 40,color:lightPurple,fontWeight: FontWeight.w600)
                      ),
                      TextSpan(
                          text: "roo",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 40,color:lightBlue,fontWeight: FontWeight.w600)
                      )
                    ])),
                    const Text.rich(TextSpan(children:[
                      TextSpan(
                          text: "Super",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:dashColor,fontWeight: FontWeight.w500)
                      ),
                      TextSpan(
                          text: " Admin",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:dashColor,fontWeight: FontWeight.w500)
                      )
                    ])),
                    const SizedBox(height: 5),
                    myText(text: "Version 1.0", fontFamily: "Poppins",fontWeight: FontWeight.w400, size: 14, textAlign: TextAlign.center,color: dashColor),

                    const Spacer(),
                    Lottie.asset(delivery),
                    const SizedBox(height: 30),
                    myText(text: "© 2021 Parcelroo Limited, West-Midlands, United Kingdom", fontFamily: "Poppins",fontWeight: FontWeight.w400, size: 14, textAlign: TextAlign.center,color: dashColor),
                    const SizedBox(height: 10),
                    const Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Company number : ",
                          style: TextStyle(fontSize: 14,fontFamily: "Poppins",color: dashColor)
                      ),
                      TextSpan(
                          text: "13340898",
                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: "Poppins",color: dashColor)
                      ),
                    ])),
                    const SizedBox(height: 30),
                  ],)
            )
        ));
  }

}
