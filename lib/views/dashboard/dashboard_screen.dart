import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcelroo_admin/utils/app_routes.dart';
import 'package:parcelroo_admin/views/dashboard/widget/dash_widgets.dart';
import 'package:parcelroo_admin/views/notifications/notifications_screen.dart';

import '../../enums/color_constants.dart';
import '../../widgets/drawerWidget.dart';
import '../../widgets/text_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
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
        title: myText(text: "Admin Dashboard", fontFamily: "Poppins",fontWeight: FontWeight.w600, size: 20, color: whiteColor),
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 20,
            spacing: 20,
            children: [
              //ACTIVATION REQUESTS
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("activationRequests").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.request_page_rounded,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Activation Requests");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.request_page_rounded,
                          total: "-",
                          type: "Activation Requests");
                    }
                  }
              ),
              //Admin Users & Subscription Type
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("companies").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.admin_panel_settings_rounded,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Admin Users & Subscription Type");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.admin_panel_settings_rounded,
                          total: "-",
                          type: "Admin Users & Subscription Type");
                    }
                  }
              ),
              //Total Drivers Signed Up
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("drivers").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.supervised_user_circle_sharp,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Total Drivers Signed Up");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.supervised_user_circle_sharp,
                          total: "-",
                          type: "Total Drivers Signed Up");
                    }
                  }
              ),
              //Vehicle Types
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("vehicles").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.airport_shuttle_rounded,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Vehicle Types");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.airport_shuttle_rounded,
                          total: "-",
                          type: "Vehicle Types");
                    }
                  }
              ),
              //All Packages
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("packages").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.all_inbox ,
                          total: snapshot.data!.docs.length.toString(),
                          type: "All Packages");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.all_inbox ,
                          total: "-",
                          type: "All Packages");
                    }
                  }
              ),
              //Business Types
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("businessTypes").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.add_business,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Business Types");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.add_business,
                          total: "-",
                          type: "Business Types");
                    }
                  }
              ),
              //All Banks
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("payment_methods").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.account_balance_rounded ,
                          total: snapshot.data!.docs.length.toString(),
                          type: "All Banks");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.account_balance_rounded ,
                          total: "-",
                          type: "All Banks");
                    }
                  }
              ),
              //Off-Boarded Companies
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("offBoard_companies").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.holiday_village_rounded ,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Off-Boarded Companies");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.holiday_village_rounded ,
                          total: "-",
                          type: "Off-Boarded Companies");
                    }
                  }
              ),
              //Off-Boarded Drivers
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("offBoard_drivers").snapshots(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.account_box_rounded ,
                          total: snapshot.data!.docs.length.toString(),
                          type: "Off-Boarded Drivers");
                    }
                    else {
                      return DashboardWidget(
                          boxColor: whiteColor,
                          iconData: Icons.account_box_rounded ,
                          total: "-",
                          type: "Off-Boarded Drivers");
                    }
                  }
              ),
            ],
          )
      )
    );
  }
}
