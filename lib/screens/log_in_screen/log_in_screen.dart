import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

import '../../componant/custom_text_field.dart';
import '../../componant/raised_button.dart';
import '../../constant/constant.dart';
 import '../register_screen/register_screen.dart';
import 'controller/log_in_controller.dart';


class LoginScreen extends StatefulWidget {
    LoginScreen({Key? key}) : super(key: key);
   @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      body:
      SafeArea(
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
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  'assets/car4.png',
                  // 'assets/logo.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              // Image.asset('assets/login.json')),


              const Text(
                "Login as a Driver",
                style: TextStyle(color: Colors.black,fontSize: 30, fontWeight: FontWeight.w500),

              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<LogInController>(
                init:  LogInController(),
                builder:(controller)=>     Column(
                children: [
                        CustomTextField(
                          inputDecoration: K.textFieldDecoration,
                          type: TextInputType.name,
                          controller:controller.emailController,
                          label: "Username",
                          color: Colors.grey,
                          fillColor: Colors.white,
                          padding: 22,
                        ),
                    CustomTextField(
                      inputDecoration: K.textFieldDecoration,
                      type: TextInputType.number,
                      label: "Password",
                      color: K.IconColor,
                      fillColor: K.TextFieldColor,
                      controller: controller.passController,
                      padding: 22,
                      isPassword: true,
                    ) ,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                          width: 300,
                          height: 40,
                          child: Button(
                            label: "Log in ",
                            function: () {
                              controller.validateForm(
                                 controller.emailController,
                                 controller.passController,
                              );
                            },
                          )),
                    ),
                ],
              ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    GestureDetector(
                      child: const Text(
                        "Log in with",
                        style: TextStyle(fontSize: 18),
                      ),onTap: (){
                    },
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
                      "Don't have an Account ? ",
                        ),
                    GestureDetector(
                      onTap: () {
                        Get.to(RegisterScreen());
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 20,
                            color: K.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
