import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parcelroo_admin/views/dashboard/dashboard_screen.dart';
import 'package:uuid/uuid.dart';
import '../../../enums/gobals.dart';
import '../../../service/api_service.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/shared_pref.dart';
import '../../../utils/toasts.dart';

class LoginProvider extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;
  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  togglePassword(){
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void handleRememberMe(bool? value) async {
    SharedPref.saveRememberMe(value!);

    if(value==true){
       SharedPref.saveEmail(emailController.text);
       SharedPref.saveUserPassword(passController.text);
    }
    _rememberMe = value;
    notifyListeners();
  }

  //ADMIN SIGN IN
  void signIn(BuildContext context, String email, String password) async {
    getIP2();
    _isLoading = true;
    notifyListeners();

    final auth = FirebaseAuth.instance;

    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        SharedPref.saveUserID(auth.currentUser!.uid.toString());
        SharedPref.saveEmail(email.toString());
        SharedPref.saveUserPassword(password.toString());
        Globals.uid = auth.currentUser!.uid.toString();
        Globals.email = email.toString();
        Globals.pass = password.toString();
        if(Globals.ipAddress!=""){
          postIPInfo(context,auth.currentUser!.uid.toString());
        }
        else{
          SharedPref.saveIsLoggedIn(true);
          ToastUtils.successToast("Login Successful", context);
          Future.delayed(const Duration(seconds: 1),(){
            AppRoutes.pushAndRemoveUntil(context,const Dashboard(firstTime:true));
          });
          _isLoading = false;
          notifyListeners();
        }

      });
    } on FirebaseAuthException catch (error) {
      ToastUtils.failureToast(error.message.toString(), context);

      _isLoading = false;
      notifyListeners();
    }
  }

  void postIPInfo(context,uid) async{
    String id = const Uuid().v1();
    log(DateTime.now().millisecondsSinceEpoch.toString());
    await firebaseFireStore.collection("users").doc(uid).collection("ipInformation").doc(id).set({
      "id":id,
      "ipAddress":Globals.ipAddress.toString(),
      "country":Globals.country,
      "city":Globals.city,
      "isoCode":Globals.isoCode,
      "dateTime":DateTime.now().millisecondsSinceEpoch.toString()

    }).then((value) {
      SharedPref.saveIsLoggedIn(true);
      ToastUtils.successToast("Login Successful", context);
      Future.delayed(const Duration(seconds: 1),(){
        AppRoutes.pushAndRemoveUntil(context,const Dashboard(firstTime:true));
      });
      _isLoading = false;
      notifyListeners();
    }).catchError((e) async {
      SharedPref.saveIsLoggedIn(true);
      ToastUtils.successToast("Login Successful", context);
      Future.delayed(const Duration(seconds: 1),(){
        AppRoutes.pushAndRemoveUntil(context,const Dashboard(firstTime:true));
      });
      _isLoading = false;
      notifyListeners();
    });


  }

  Future<void> getIP2() async {
    ApiService().getIP().then((response) {
      if (response.statusCode == 200) {
        log("IP ADDRESS ----- ${json.decode(response.body)["traits"]["ip_address"].toString()}");
        log("ISO CODE ----- ${json.decode(response.body)["country"]["iso_code"].toString()}");
        log("CITY ----- ${json.decode(response.body)["city"]["names"]["en"].toString()}");
        log("COUNTRY ----- ${json.decode(response.body)["country"]["names"]["en"].toString()}");
        Globals.ipAddress= json.decode(response.body)["traits"]["ip_address"].toString();
        Globals.isoCode= json.decode(response.body)["country"]["iso_code"].toString();
        Globals.country= json.decode(response.body)["country"]["names"]["en"].toString();
        Globals.city= json.decode(response.body)["city"]["names"]["en"].toString();
        notifyListeners();

      } else {
        Globals.ipAddress= "";
        Globals.isoCode= "";
        Globals.country= "";
        Globals.city ="";
        notifyListeners();
      }
    });
  }

  void loadUserEmailPassword(context) async {
    try {
      var username = await SharedPref.getEmail();
      var password = await SharedPref.getUserPassword();
      var rememberMe = await SharedPref.getRememberMe();

      if (rememberMe) {
        _rememberMe = true;
        emailController.text = username.toString();
        passController.text = password.toString();
        notifyListeners();
      } else {
        _rememberMe = false;
        emailController.text = username.toString();
        passController.text = password.toString();
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }

}