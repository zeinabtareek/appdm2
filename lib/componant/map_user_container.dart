
import 'package:animation_uber_user/componant/user_image_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../screens/maps_screens/controller/map_controller.dart';

class MapUserContainer extends StatelessWidget {
    MapUserContainer({
    Key? key,required this.isSelected
  }) : super(key: key);
bool ?isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        padding: EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        decoration: BoxDecoration(
            color: isSelected==true?K.mainColor:Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: K.BlackColor.withOpacity(.2),
                  blurRadius: 10,
                  offset: Offset.zero
              )
            ]
        ),
        duration: const Duration(
          milliseconds: 700,
        ),
        curve: Curves.easeIn,
        child:GetBuilder<MapController>(
        init :MapController(),
    builder:(controller) {
      return Row(
          children: [
            UserImageCircle(isSelected: this.isSelected,),
            const SizedBox(width: 10,),
            Expanded(child:
     Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                Text('Roman Jaquez',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: this.isSelected==true?Colors.white:K.IconColor
                  ),),
                  Text('My Location',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:this.isSelected==true?Colors.white: K.mainColor
                  ),),
              ],
            )),

            InkWell(
              child: Icon(Icons.location_pin,

                color: this.isSelected==true?Colors.white:K.mainColor,
                size: 40,
              ),
              onTap: (){
                controller.getCurrentLocation();
              },
            )
          ],
        );}
        )

    );
  }
}

