import 'dart:io';
import 'package:animation_uber_user/screens/log_in_screen/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../componant/custom_text_field.dart';
import '../../componant/raised_button.dart';
import '../../constant/constant.dart';
import '../load_screen.dart';
  import 'controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.9),
         body:   GetBuilder<RegisterController>(
           init:  RegisterController(),
           builder:(controller)=>Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              child: Lottie.asset(
                                'assets/logo-ubiweb.json',
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),]),
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: Image.asset(
                                          'assets/car4.png',

                            // 'assets/login.json',
                            width: 600,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text(
                          "Register as a Driver",
                          style: TextStyle(color: Colors.black,fontSize: 30, fontWeight: FontWeight.w500),

                        ),
                        const SizedBox(
                          height: 30,
                        ),
                    GetBuilder<RegisterController>(
                      init:  RegisterController(),
                      builder:(controller)=> Column(
                          children: [
                        CustomTextField(
                            inputDecoration: K.textFieldDecoration,
                            label: "Full Name",
                             controller:  controller.nameController,
                            fillColor: K.TextFieldColor,
                            color: K.IconColor,
                            onChanged: (name) {
                            }, padding: 22,
                          ),
                        CustomTextField(
                            inputDecoration: K.textFieldDecoration,
                            label: "Email Address",
                            color: K.IconColor,
                            controller: controller.emailController,
                             fillColor: K.TextFieldColor,
                            onChanged: (username) {
                             }, padding: 22,
                          ),
                        CustomTextField(
                            inputDecoration: K.textFieldDecoration,
                            label: "Phone ",
                            color: K.IconColor,
                          type: TextInputType.number,
                          controller: controller.phoneController,
                            fillColor: K.TextFieldColor,
                            onChanged: (username) {

                            }, padding: 22,
                          ),
                        CustomTextField(
                            inputDecoration: K.textFieldDecoration,
                            label: "Password",
                            type: TextInputType.text,
                            isPassword: true,
                             fillColor: K.TextFieldColor,
                            controller: controller.passController,
                            color: K.IconColor,
                                 padding: 22,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: SizedBox(
                                width: 300,
                                height: 40,
                                child:
                                  Button(
                                    label: "Create Account",
                                    function: () {
                                      controller.validateForm(
                                          controller.nameController,
                                          controller.emailController,
                                          controller.phoneController,
                                          controller.passController,
                                      );
                                    },
                                  )
                                ),
                            ),
                          ),
                          ],
                        ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already a member / ",
                                style: TextStyle(
                                    fontSize: 18, color: K.IconColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(  LoginScreen());
                                },
                                child: const Text(
                                  "log in",
                                  style:  TextStyle(
                                      fontSize: 18, color: K.mainColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
              )
    );
  }
}
