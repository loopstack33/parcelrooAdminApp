import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcelroo_admin/views/dashboard/controller/dash_controller.dart';
import 'package:provider/provider.dart';

import '../../enums/color_constants.dart';
import '../../utils/app_routes.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/drawerWidget.dart';
import '../../widgets/text_widget.dart';
import '../notifications/notifications_screen.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    DashController dashController= Provider.of<DashController>(context, listen: false);
    bool passwordVisible = context.watch<DashController>().passwordVisible;
    return Scaffold(
      backgroundColor: dashColor,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon:  const Icon(
                Icons.menu,
                color: whiteColor,
                size: 25,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor:dashColor,
        title: myText(text: "Settings", fontFamily: "Poppins",fontWeight: FontWeight.w600, size: 20, color: whiteColor),
        centerTitle: true,
        actions: [
          Padding(padding:const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () => AppRoutes.push(context, const NotificationScreen()),
                child:const Icon(Icons.notifications_active_rounded,color: whiteColor,size: 25),
              ))
        ],
      ),
      drawer:const DrawerMobileWidget(),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(25),
        child: Column(
          children: [
            CustomTextField(controller: dashController.emailController, hint: "Your Email",suffixIcon: const Icon(Icons.email,color: greyDark,size: 25),
                validator: (value) {
                  if(value ==null || value.isEmpty){
                    return "Please Enter Your Email";

                  }
                  else if((RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value) ==
                      false) ){
                    return "Please Enter Valid Email";
                  }

                  return null;
                }),
            const SizedBox(height: 20),
            CustomTextField(
                validator: (value) {

                  if(value ==null || value.isEmpty){
                    return "Please Enter Your Password";
                  }

                  return null;
                },
                controller: dashController.passController,
                hint: "Your Password",
                obscure:  dashController.passwordVisible,
                suffixIcon: InkWell(
                    onTap: () {
                      dashController.togglePassword();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        passwordVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded,
                        size: 25,
                      ),
                    )),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ]),
          ],
        ),
      ),
    );
  }
}
