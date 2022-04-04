 import 'package:flutter/material.dart';

import '../constant/constant.dart';

class Button extends StatelessWidget {
  final String label;
  VoidCallback  function;
  final Color color;
  final Color colorText;

  Button(
      {required this.label,
        required this.function,
        this.color = Colors.white,
        this.colorText = K.mainColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 150,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: K.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: function,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 20,
                color: Colors.white),
          ),
        ));
  }
}
