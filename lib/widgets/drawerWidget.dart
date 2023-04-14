// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcelroo_admin/views/ipInformation/ip_information.dart';
import 'package:parcelroo_admin/widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../enums/color_constants.dart';
import '../enums/gobals.dart';
import '../utils/app_routes.dart';
import '../utils/shared_pref.dart';
import '../views/dashboard/dashboard_screen.dart';
import '../views/login/login_screen.dart';
import '../views/settings/settings_screen.dart';

class DrawerMobileWidget extends StatefulWidget {
  const DrawerMobileWidget({Key? key}) : super(key: key);

  @override
  State<DrawerMobileWidget> createState() => _DrawerMobileWidgetState();
}

class _DrawerMobileWidgetState extends State<DrawerMobileWidget> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: drawerColor,
        child:Column(
          children: [
            Expanded(child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                 Padding(
                    padding:const EdgeInsets.only(top: 50,bottom: 20),
                    child: Image.asset("assets/images/logo.png",width: 50,height: 50),
                ),
                ListTile(
                  hoverColor: whiteColor.withOpacity(0.25),
                  title: myText(text: "Dashboard", fontFamily: "Poppins", size: 16, color: whiteColor),
                  leading: const Icon(Icons.home,color: whiteColor,size: 25),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const Dashboard()),
                            (Route<dynamic> route) => false);
                  },
                ),
                ListTile(
                  hoverColor: whiteColor.withOpacity(0.25),
                  title: myText(text: "IP Information", fontFamily: "Poppins", size: 16, color: whiteColor),
                  leading: const Icon(CupertinoIcons.globe,color: whiteColor,size: 25),
                  onTap: () {
                    AppRoutes.push(context, const IPInformation());
                  },
                ),
                ListTile(
                  hoverColor: whiteColor.withOpacity(0.25),
                  title:  myText(text: "Settings", fontFamily: "Poppins", size: 16, color: whiteColor),
                  leading: const Icon(Icons.settings,color: whiteColor,size: 25),
                  onTap: () {
                    AppRoutes.pop(context);
                    AppRoutes.push(context, const Settings());
                  },
                ),

                ListTile(
                  hoverColor: whiteColor.withOpacity(0.25),
                  title:  myText(text: "Logout", fontFamily: "Poppins", size: 16, color: whiteColor),
                  leading: const Icon(Icons.exit_to_app,color: whiteColor,size: 25),
                  onTap: () {

                    // Create button
                    Widget okButton = ElevatedButton(
                      child:myText(text: "Yes", fontFamily: "Poppins", fontWeight: FontWeight.w400,size: 14, color: whiteColor),
                      onPressed: () {
                        logOut();
                      },
                    );

                    // Create button
                    Widget noButton = TextButton(
                      child:myText(text: "No", fontFamily: "Poppins",  fontWeight: FontWeight.w400,size: 14, color: dashColor),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );

                    // Create AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: myText(text: "Alert!", fontFamily: "Poppins", fontWeight: FontWeight.w600,size: 16, color: dashColor),
                      content:myText(text: "Do you want to logout?", fontFamily: "Poppins", size: 16, color: dashColor),
                      actions: [
                        noButton,
                        okButton,

                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                ),
              ],
            )),
            Align(
                alignment: FractionalOffset.bottomCenter,
                child:  Column(
                  children: [
                    const Text.rich(TextSpan(children:[
                      TextSpan(
                          text: "Parcel",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:lightBlue,fontWeight: FontWeight.w600)
                      ),
                      TextSpan(
                          text: "roo",
                          style: TextStyle(fontFamily: "Poppins",fontSize: 20,color:lightPurple,fontWeight: FontWeight.w600)
                      )
                    ])),
                    const SizedBox(height: 10,),
                    myText(text: "Version 1.0", fontFamily: "Poppins", size: 16, color: whiteColor),
                    const SizedBox(height: 20,),
                  ],
                )
            )

          ],
        )
    );
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool("remember_me");
    prefs.setBool("isLoggedIn", false);

    if (rememberMe == false) {
      prefs.clear();
    } else {
      SharedPref.saveUserID("null");
    }
    if (mounted) {
      setState(() {
        SharedPref.saveIsLoggedIn(false);
        Globals.uid = "null";
        Globals.email ="null";
        Globals.pass = "null";
      });
    }
    FirebaseMessaging.instance.deleteToken();
    AppRoutes.pushAndRemoveUntil(context, const LoginScreen());
  }

}


