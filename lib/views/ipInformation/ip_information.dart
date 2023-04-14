import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parcelroo_admin/views/ipInformation/widget/ipWidget.dart';

import '../../enums/color_constants.dart';
import '../../utils/app_routes.dart';
import '../../widgets/drawerWidget.dart';
import '../../widgets/text_widget.dart';
import '../notifications/notifications_screen.dart';

class IPInformation extends StatefulWidget {
  const IPInformation({Key? key}) : super(key: key);

  @override
  State<IPInformation> createState() => _IPInformationState();
}

class _IPInformationState extends State<IPInformation> {

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
        title: myText(text: "IP Information", fontFamily: "Poppins",fontWeight: FontWeight.w600, size: 20, color: whiteColor),
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").doc("wxet9qYga0dPdKZe5lbbtDNHmg72").collection("ipInformation").orderBy("dateTime",descending: true).snapshots(),
          builder: (context,snapshot) {

            if(snapshot.hasData){
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15),
                shrinkWrap: true,
                itemBuilder: (context,index){
                  DocumentSnapshot  snap =  snapshot.data!.docs[index];
                  return IPWidget(ip: snap["ipAddress"], dateTime: snap["dateTime"], country: snap["country"], city: snap["city"]);
                },
                itemCount: snapshot.data!.docs.length,);
            }
            else {
              return const Center(
                child: CircularProgressIndicator(
                  color: darkPurple,
                ),
              );
            }
          }
      ),
    );
  }
}

