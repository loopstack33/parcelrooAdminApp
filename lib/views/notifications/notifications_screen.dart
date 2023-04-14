import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcelroo_admin/views/notifications/widgets/notification_widget.dart';

import '../../enums/color_constants.dart';
import '../../widgets/text_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashColor,
      appBar: AppBar(
        backgroundColor:dashColor,
        title: myText(text: "Notifications", fontFamily: "Poppins",fontWeight: FontWeight.w600, size: 20, color: whiteColor),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").doc("wxet9qYga0dPdKZe5lbbtDNHmg72").collection("notifications").orderBy("dateTime",descending: true).snapshots(),
          builder: (context,snapshot) {

            if(snapshot.hasData){
              List<dynamic> notifications = snapshot.data!.docs;
              if(notifications.isNotEmpty){
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    DocumentSnapshot  snap =  snapshot.data!.docs[index];
                    return NotificationWidget(message: snap["message"], dateTime: snap["dateTime"], type: snap["type"]);
                  },
                  itemCount: snapshot.data!.docs.length,);
              }
              else{
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 120,
                      decoration:const BoxDecoration(
                        color: Color.fromRGBO(251, 176, 59,1),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.white.withOpacity(.8),
                        size: 40,
                      ),
                    ),
                    const Align(
                      child: Padding(
                        padding:  EdgeInsets.all(15),
                        child: Text( "No Notifications Found",
                          textAlign: TextAlign.center,
                          style:
                          TextStyle(fontSize: 20,fontFamily: 'Poppins', color: whiteColor,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              }

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
