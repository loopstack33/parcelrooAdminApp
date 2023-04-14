import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/* -------- 14-Apr-2023 -------- */
class DashController extends ChangeNotifier{

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool _passwordVisible=true;
  bool get passwordVisible => _passwordVisible;

  togglePassword(){
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }


  Future<void> getUserData() async{
    await firebaseFireStore
        .collection('users')
        .doc("wxet9qYga0dPdKZe5lbbtDNHmg72")
        .get()
        .then((value) {
      emailController.text = value.data()!["email"];
      passController.text = value.data()!["password"];
      _isLoading = false;
      notifyListeners();
    }).catchError((e) async {
      log(e.toString());
      // ToastUtils.failureToast(e.toString(), context);
    });
  }

}