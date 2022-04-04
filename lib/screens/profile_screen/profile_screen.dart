import 'package:animation_uber_user/screens/register_screen/controller/register_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class ProfileScreen extends StatelessWidget {
    ProfileScreen({Key? key}) : super(key: key);
  RegisterController registerController=RegisterController();
  @override
  Widget build(BuildContext context) {
    return Center(

      child: FlatButton(
        onPressed: () { registerController.signout(); },
        child: Text('Click'),
      ),
    );
  }
}
