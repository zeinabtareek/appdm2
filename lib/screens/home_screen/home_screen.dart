import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/constant.dart';
import '../../data.dart';
import '../../model/search_suggestion_model.dart';
import '../maps_screens/map_screen.dart';

 class HomeScreen extends StatelessWidget {
@override
  Key key =UniqueKey();

PlaceDetail placeDetail=PlaceDetail();
  late StreamSink<PlaceDetail> sink;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 10.0,
              backgroundImage:NetworkImage('https://icon-library.com/images/person-icon-png-transparent/person-icon-png-transparent-3.jpg',
              ),
           ),
         ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:   [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: K.mainColor,
                child: Stack(
                  children: [
                     Positioned(
                      // right:0,
                      child :Container(
                        padding: EdgeInsets.fromLTRB(6, 19, 0, 20),
                      height: 150,
                      width: double.infinity,
                      child:const Text(
                          'Do you want to apply another  \nbetter methodologies\n cintact our customer \nservices center now ➡️',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                              )
                    ),
                    ),
                    Positioned(
                      right: -45,
                      child:
                      Image.asset('assets/card.png',width: 250,))
                  ],
                ),
              ),
              Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: const [
                 SizedBox(width: 10,),
                 Text('Type of your Shipment :',style: TextStyle(
                   fontSize: 18
                  ),
                 ),
               ],
             ),
              Padding(
                 padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 0),
                 child: Wrap(direction: Axis.horizontal,
                   crossAxisAlignment: WrapCrossAlignment.center,
                   children: [
                     ...List.generate(HomeImages.length, (index) => Column(
                       children: [
                         InkWell(
                           child: Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15.0),
                             ),color: Colors.white,
                             child: Container(
                                 width:MediaQuery.of(context).size.width/4.7,
                                 padding: EdgeInsets.all(5),
                                 height: 55,
                                 child: Center(
                                   child: Image.network(HomeImages[index].toString()
                                     ,fit: BoxFit.contain,
                                     width: double.infinity,
                                   ),
                                 )
                             ),

                           ),
                         ),Text(HomeLabels[index].toString(),style: const TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w500
                         ),),
                       ],
                     ),
                    ),
                   ],
                 ),
               ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.withOpacity(.4),),
                padding: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 20),
                height: 60,
                width: double.infinity,
                child: const Text('Assign the Pickup Point',
                  style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500))
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(.2),
                    ),
                    child: IconButton(
                        onPressed: (){
                          Get.to(MapScreen(title: '',));

                        }
                        , icon: const Icon(Icons.location_on)),
                  ), const SizedBox(
                    width: 10,
                  ),
                  const Text('Define your destination on the map',style: TextStyle(fontSize: 16 ,
                    decoration: TextDecoration.underline,
                  ),),
                  IconButton(
                    onPressed: (){
                      Get.to(MapScreen(title: '',));
                    }
                    ,icon: const Icon(Icons.arrow_forward_ios_outlined)),
                ],
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.asset('assets/map.png')
                  ),
                   Padding(
                     padding:  const EdgeInsets.only(top: 25 ,left: 25,right: 25,bottom: 0),
                     child: Card(
                        child: Container(
                          height: 200,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Total Transactions',style: TextStyle(
                                fontSize: 18 ,
                                decoration: TextDecoration.underline,
                              ),),
                              const SizedBox(height: 10,),
                              const Divider(),
                              Divider(),
                              const Text('12',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                ),),
                              const SizedBox(height: 10,),
                              FlatButton(
                                minWidth: 250,
                                height: 50,
                                color: K.mainColor.withOpacity(.5),
                                onPressed: (){},
                                child: const Text('History Details   >',style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                 ),
                                ),
                              ),
                            ],
                          ),
                        ),
                     ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
