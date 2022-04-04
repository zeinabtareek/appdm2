import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class UserImageCircle extends StatelessWidget {
    UserImageCircle({
    Key? key,required this.isSelected
  }) : super(key: key);
  bool ?isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          image: const DecorationImage(
              image: AssetImage('assets/driver.png',),
              fit: BoxFit.cover
          ),
          border: Border.all(
              color: isSelected==true?Colors.white:K.mainColor,
              width: 1
          )
      ),
    );
  }
}
