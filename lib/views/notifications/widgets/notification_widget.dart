import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parcelroo_admin/enums/color_constants.dart';

class NotificationWidget extends StatelessWidget {
  final String type, message, dateTime;
  const NotificationWidget({Key? key,required this.dateTime,required this.message,required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10,bottom: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: dashColor, width: 1),
        boxShadow: [
          BoxShadow(
              offset: const Offset(2, 2),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5)
        ],
      ),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        type,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          message,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                  const Icon(Icons.notifications,color: Color.fromRGBO(251, 176, 59,1),),
                ],
              ),
              Text(DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateTime))).toString(),style: const TextStyle(fontSize: 13,fontFamily: 'Poppins'),)
            ],
          ),

        ],
      ),
    );
  }
}
