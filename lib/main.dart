import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcelroo_admin/providers/multi_provider.dart';
import 'package:parcelroo_admin/service/fcm_services.dart';
import 'package:parcelroo_admin/service/local_notifications.dart';
import 'package:parcelroo_admin/views/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await LocalNotificationsService.instance.initialize();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FCMServices.fcmGetTokenandSubscribe('parcelrooAdmin');
  fcmListen();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _messageHandler(RemoteMessage event) async {

  if(event.data['id'].toString()== FirebaseAuth.instance.currentUser?.uid){
    LocalNotificationsService.instance.showNotification(
        title: '${event.notification?.title}',
        body: '${event.notification?.body}');

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationsService.instance.showNotification(
          title: '${event.notification?.title}',
          body: '${event.notification?.body}');
    });
    log("Handling a background message: ${event.messageId}");
  }
  else if(event.data['id'].toString()=="0"){
    LocalNotificationsService.instance.showNotification(
        title: '${event.notification?.title}',
        body: '${event.notification?.body}');

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationsService.instance.showNotification(
          title: '${event.notification?.title}',
          body: '${event.notification?.body}');
    });
    log("Handling a background message: ${event.messageId}");
  }

}

fcmListen() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {

    if(event.data['id'].toString()== FirebaseAuth.instance.currentUser?.uid) {
      LocalNotificationsService.instance.showNotification(
          title: '${event.notification?.title}',
          body: '${event.notification?.body}');

      FirebaseMessaging.onMessageOpenedApp.listen((message) {});
    }
    else if(event.data['id'].toString()=="0"){
      LocalNotificationsService.instance.showNotification(
          title: '${event.notification?.title}',
          body: '${event.notification?.body}');

      FirebaseMessaging.onMessageOpenedApp.listen((message) {});
      log("Handling a background message: ${event.messageId}");
    }
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProvider,
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Parcelroo SuperAdmin',
        home: const SplashScreen(),
      ),
    );

  }
}
