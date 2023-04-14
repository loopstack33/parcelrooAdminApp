// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:firebase_messaging/firebase_messaging.dart';


const firebaseKey = "AAAA_raebm0:APA91bHfoC028NDLt5tM57voQjQCFXcyKq_VCBjW6MrpQepYX6qwC42M1bvBdxH8qOM_lrjUCmnUTNyI_ac_ELQL5hMpY5QsF35LhnkS4qXHpanE8T09F3Z4-Lj1f9DUhFun1pCBHWcm";

/* -------- 14-Apr-2023 -------- */
class FCMServices {
  static fcmGetTokenandSubscribe(topic) {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseMessaging.instance.subscribeToTopic("$topic");
    });
  }

}
