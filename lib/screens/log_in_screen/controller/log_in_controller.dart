



 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constant/constant.dart';
import '../../../services/authentications/register_services.dart';
import '../../home_navigation_bar/home.dart';
import '../../load_screen.dart';

class LogInController extends GetxController {
  final services = RegisterServices();
  final emailController = TextEditingController();
  final passController = TextEditingController();



  void login() async
  {

  final User? firebaseUser;

    firebaseUser= (await services.auth
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),

    ).catchError((msg) {
      Fluttertoast.showToast(msg: 'Error*in login : $msg'.toString());
    })).user;

    if (firebaseUser != null) {

      services.currentFirebaseUser.value = firebaseUser ;
      Fluttertoast.showToast(msg: 'Login Successful');

      Get.to(  LoadingScreen());

    } else {
      Get.back();
      Fluttertoast.showToast(msg: 'Error while sign in');
    }

  }




  validateForm(  emailController,   passController) {
    try {
     if (!emailController.text.contains('@')) {
        Fluttertoast.showToast(
            msg: "Email address is not valid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);
      }

      else if (passController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Password is mandatory",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: K.BlackColor,
            textColor: Colors.white,
            fontSize: 12.0);
      }
      else {
       login( );
      }
    } catch (on) {
      printError(info: 'error');
    }
  }



}