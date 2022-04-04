import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../services/authentications/register_services.dart';
import '../../home_navigation_bar/home.dart';
 import '../../log_in_screen/log_in_screen.dart';


class RegisterController extends GetxController {
  final services = RegisterServices();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => this._firebaseUser.value;


  validateForm(
      nameController, emailController, phoneController, passController) {
    try {
      if (nameController.text.length < 3) {
        Fluttertoast.showToast(
            msg: "Name must be atleast 3 Characters",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);
      }
      else if (!emailController.text.contains('@')) {
        Fluttertoast.showToast(
            msg: "Email address is not valid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);
      }
      else if (phoneController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Phone Number is mandatory",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);
      }
      else if (passController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Password must be atleast 6 Characters",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);
      }
      else {
        Fluttertoast.showToast(msg: 'yor email has been created');
        // Get.to(const CarInfoScreen());
        saveDriverInfo();
      }
    } catch (on) {
      printError(info: 'error');
    }
  }

  clearForm() {}

  Future saveDriverInfo() async {

    // final User? firebaseUser
    _firebaseUser.value= (await services.auth
            .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),

    ).catchError((msg) {
      Fluttertoast.showToast(msg: 'Error***********************************: $msg'.toString());
    })).user;

    if (_firebaseUser != null) {
      Map userMap = {
        'id': _firebaseUser.value!.uid,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        // 'password':passController.text.trim(),
      };
      DatabaseReference driversRef = await services.store.ref("users");
      driversRef.child(_firebaseUser.value!.uid.toString()).set(userMap);

      services.currentFirebaseUser.value = _firebaseUser.value ;
      Get.to(const Home());

    } else {
      // Get.back();
      Fluttertoast.showToast(msg: 'Account has not been Created');
    }
  }





  void signout() async{
    await services.auth.signOut().then((value) => Get.offAll(LoginScreen()));
  }

}
