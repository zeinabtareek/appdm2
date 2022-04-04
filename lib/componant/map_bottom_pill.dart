import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../screens/maps_screens/controller/map_controller.dart';

class MapBottomPill extends StatelessWidget {
  const MapBottomPill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: K.BlackColor.withOpacity(.2),
                blurRadius: 10,
                offset: Offset.zero
            )
          ]
      ),
      child: GetBuilder<MapController>(
          init :MapController(),
          builder:(controller)=>    Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Stack(
                  clipBehavior:Clip.none,
                  children: [
                    ClipOval(
                      child:Image.asset('assets/driver.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child:   ClipOval(
                        child:
                      Container(
                        padding: EdgeInsets.all(3),
                        color: K.mainColor,
                        child:const Icon(
                          Icons.wb_auto_outlined,color: Colors.white,
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.searchController.text.toString().toUpperCase(),
                      style: TextStyle(
                        color: K.IconColor[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const Text('Venta por Libra'),
                      Text("Total Distance: " + controller.distance.toStringAsFixed(2) + " KM",
                      style: TextStyle(
                        color: K.mainColor,
                      ),),
                  ],
                ),
                ),
                const Icon(Icons.location_pin,color: K.mainColor,size: 50,)

              ],
            ),),
        Row(
          children: [   Container(

              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: const DecorationImage(
                                image: AssetImage('assets/farmer.png'),
                                fit: BoxFit.cover
                            ),
                            border: Border.all(color: K.IconColor,
                                width: 4)
                        ),
                      )
                    ],
                  ),
                ],
              )
          ),
            const SizedBox(
              width: 30,
            ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.searchDesTextEditing.text.toString().toUpperCase(),
                style: const TextStyle(
                  color: K.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Text(controller.street.toString(),style: const TextStyle(
                  fontWeight: FontWeight.w600
              ),),

              Text(controller.administrativeArea.toString(),style: const TextStyle(
                  fontWeight: FontWeight.w600
              ),),
              //
              // Text(controller.address.toString(),style: const TextStyle(
              //     fontWeight: FontWeight.w600
              // ),),
            ],
          )
         ],
        ), ],
        ),
      ),
    );
  }
}
