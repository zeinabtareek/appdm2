// import 'dart:async';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../componant/map_bottom_pill.dart';
// import '../../componant/map_user_container.dart';
// import '../../componant/search_bottom _to.dart';
// import '../../componant/serch_bottom_field.dart';
// import '../../componant/user_image_circle.dart';
// import '../../constant/constant.dart';
//  import '../../model/search_suggestion_model.dart';
// import '../../services/search_suggestion.dart';
// import 'controller/map_controller.dart';
// import '../../services/search_service.dart';
// import 'package:uuid/uuid.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key, required String title}) : super(key: key);
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     CarouselController carouselController = CarouselController();
//     MapController mapController=Get.put(MapController());
//     final sessionToken = Uuid().v4();
//     final providerC = (Uuid().v4());
//
//     List<Suggestion> suggestion = [];
//
//     final title;
//     final StreamSink<PlaceDetail> ?sink;
//
//     return GetBuilder<MapController>(
//       init :MapController(),
//       builder:(controller)=>   Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           leading: const Icon(
//             Icons.menu, color: K.mainColor,
//             size: 25,
//           ),
//           title:   Center(
//             child: Image.asset('assets/logo22.png',
//               width: 150,
//             ),),
//           elevation: 0.0,
//           iconTheme: const IconThemeData(
//             color: K.mainColor,
//           ),actions: [
//           Opacity(opacity:1,
//             child: Container(
//               margin: EdgeInsets.only(right: 10),
//               padding: EdgeInsets.all(10),
//               child:UserImageCircle(
//                 isSelected:controller.checkUserBadgetSelected.value,
//               ),
//             ),
//           )
//         ],),
//         body: GetBuilder<MapController>(
//           init :MapController(),
//           builder:(controller)=>  Stack(children: [
//
//             Positioned.fill(
//               child: GoogleMap(
//                 mapType: MapType.normal,
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//                 markers: controller.markers,
//                 tiltGesturesEnabled: false,
//                 onCameraMove: controller.onCameraMove,
//
//                 // polylines: controller.polyLines,
//                 polylines: Set<Polyline>.of(controller.polyLines),
//
//                 compassEnabled: false,
//                 onTap: (LatLng loc){
//                   controller.checkFun();
//                   print('${loc.latitude}, ${loc.longitude}');
//                   controller.getAddressFromLatLng(loc);
//                   controller.calculateDistanceFunc(loc.latitude,loc.longitude);
//
//                 },
//                 initialCameraPosition:  _kGooglePlex  ,
//
//                 // initialCameraPosition: controller.initialCameraPOstion,
//                 onMapCreated: (GoogleMapController googleMap) {
//                   controller.blackGoogleMapControllerSwitch(googleMap);
//                   controller.showPinsOnMap();
//                   controller.setPolylines();
//                 },),
//             ),
//             Positioned(
//                 top: 100,
//                 left: 0,
//                 right: 0,
//                 child:
//                 MapUserContainer(
//                   isSelected:controller.checkUserBadgetSelected.value,
//                 )),
//
//
//
//             Positioned(
//               top: 140,
//               left: 0,
//               right: 0,
//               child:
//
//               GetBuilder<MapController>(
//                   init :MapController(),
//                   builder:(controller) {
//                     if((controller.searchresultsfrom!=null && controller.searchresultsfrom.length!=0) ) {
//                       return Container(
//                         // padding: EdgeInsets.all(3),
//                         height: 700,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             color: K.BlackColor.withOpacity(.6),
//                             backgroundBlendMode: BlendMode.darken
//                         ),
//                         child: Obx(()=>ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             // scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: controller.searchresultsfrom.length,
//                             itemBuilder: (context ,index){
//                               return ListTile(
//                                   title: Text(
//                                     controller.searchresultsfrom[index].description.toString(),
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     // controller.checkFun();
//                                     SearchServices().getPlace(mapController.searchController.text);
//
//
//                                   }
//                               );
//                             }
//                         ),
//                         ),
//                       );
//                     }else{
//                       return Container();
//                     }
//                   }
//               ),
//             ),
//             AnimatedPositioned(
//                 left: 0,
//                 right: 0,
//                 bottom: controller.pinPillPosition,
//                 duration: Duration(milliseconds: 700),
//                 curve: Curves.easeIn,
//                 child: MapBottomPill()
//             ),
//             AnimatedPositioned(
//                 left: 0,
//                 right: 0,
//                 bottom: controller.searchPillPosition,
//                 duration: Duration(milliseconds: 700),
//                 curve: Curves.easeIn,
//                 child: searchBottom()
//             ),
//
//
//
//             /***************************Test*************************/
//           ],
//           ),
//         ),
//
//
//         floatingActionButton: FloatingActionButton.extended(
//           // onPressed: controller.goToTheLake,
//           onPressed: (){},
//           label: Text('To the lake!'),
//           icon: Icon(Icons.directions_boat),
//         ),
//
//
//       ),
//     );
//   }
//
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   Completer<GoogleMapController> _controller = Completer();
//
// }
//
//
//
//
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../componant/map_bottom_pill.dart';
import '../../componant/map_user_container.dart';
import '../../componant/serch_bottom_field.dart';
import '../../componant/user_image_circle.dart';
import '../../constant/constant.dart';
import '../../services/search_service.dart';
import 'controller/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapController mapController =Get.put(MapController());



  @override
  Widget build(BuildContext context) {
    return    GetBuilder<MapController>(
      init :MapController(),
      builder:(controller)=>  Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.menu, color: K.mainColor,
            size: 25,
          ),
          title:   Center(
            child: Image.asset('assets/logo22.png',
              width: 150,
            ),),
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: K.mainColor,
          ),actions: [
          Opacity(opacity:1,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              child:UserImageCircle(
                isSelected:controller.checkUserBadgetSelected.value,
              ),
            ),
          )
        ],),
        body: SafeArea(child:
        Stack(children: [
          Positioned.fill(

            child:GoogleMap(
              mapType: MapType.normal,
              markers: controller.markers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onCameraMove: controller.onCameraMove,
              polylines: Set<Polyline>.of(controller.polyLines),
              initialCameraPosition: controller.initialCameraPOstion,
              onMapCreated: (GoogleMapController gcontroller) {
                controller.blackGoogleMapControllerSwitch(gcontroller);
                controller.showPinsOnMap(controller.currentLocation!,controller.destinationLocation!);
                controller.setPolylines(controller.currentLocation!,controller.destinationLocation!);
                _controller.complete(gcontroller);
              },

               onTap: (LatLng loc){
                  controller.checkFun();
                  print('${loc.latitude}, ${loc.longitude}');
                  controller.getAddressFromLatLng(loc);
                  // controller.calculateDistanceFunc(loc.latitude,loc.longitude);

                },
            ), ),
          Positioned(
              top: 40,
              left: 0,
              right: 0,
              child:
              MapUserContainer(
                isSelected:controller.checkUserBadgetSelected.value,
              )),



          Positioned(
            top: 112,
            left: 0,
            right: 0,
            child:
            GetBuilder<MapController>(
                init :MapController(),
                builder:(controller) {
                  if((controller.searchresultsfrom!=null && controller.searchresultsfrom.length!=0) ) {
                    return Container(
// padding: EdgeInsets.all(3),
                      height: 700,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: K.BlackColor.withOpacity(.6),
                          backgroundBlendMode: BlendMode.darken
                      ),
                      child: Obx(()=>ListView.builder(
                          scrollDirection: Axis.vertical,
// scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.searchresultsfrom.length,
                          itemBuilder: (context ,index){
                            return  GetBuilder<MapController>(
                                init :MapController(),
                                builder:(controller) =>ListTile(
                                    title: Text(
                                      controller.searchresultsfrom[index].description.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () async{
                                      controller.checkFun();
                                      var place=await SearchServices().getPlace(controller.searchController.text);
                                      // await  goToPlace(place);
                                    })
                            );
                          }
                      ),
                      ),
                    );
                  }else{
                    return Container();
                  }
                }
            ),
          ),
          AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: controller.pinPillPosition,
              duration: Duration(milliseconds: 700),
              curve: Curves.easeIn,
              child: MapBottomPill()
          ),
          GetBuilder<MapController>(
            init :MapController(),
            builder:(controller) => AnimatedPositioned(
              left: 0,
              right: 0,
              bottom: controller.searchPillPosition,
              duration: Duration(milliseconds: 700),
              curve: Curves.easeIn,
              child:searchBottom(),
//                 TextFormField(
// // keyboardType: TextInputType.text,
//                     textCapitalization: TextCapitalization.words,
//                     controller: controller.searchController ,
// // controller: controller.searchInputTextEditing ,
// // textInputAction: TextInputAction.next,
//                     cursorColor: Colors.black,
//                     decoration: getInoutDecoration(
//                       "pick up Location?",
//                       const Icon(
//                         Icons.location_on,
//                         color: Colors.green,
//                       ),
//                     ),
//                     onChanged: (value) {
//                       controller.searchPlacesfrom(value);
//                       print(value);
//                     }
//
//                 ),
              ),

          ),



        ],
        ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Text(controller.checkOut!=true ?'Go':'Commit >',style: const TextStyle(
              fontSize: 18
            ),),
             backgroundColor: Colors.green,
             onPressed: ()async{
              var directions =await SearchServices().getDirections(
                  controller.searchController.text,
                  controller.searchDesTextEditing.text,
              );
              // var place=await SearchServices().getPlace(controller.searchController.text);
              await  goToPlace(
                  directions['start_location']['lat'],
                  directions['start_location']['lng'],
                  directions['end_location']['lat'],
                  directions['end_location']['lng'],
                  directions['bounds_ne'],
                  directions['bounds_sw'],

              );
                 controller.remove();
              controller.checkOutFunc();

             }
        ),  floatingActionButtonLocation:FloatingActionButtonLocation.endDocked ,

      ),
    );
  }

  Future<void> goToPlace(
      double lat, double lng,
      double lat2, double lng2,
      Map<String,dynamic>boundsNe,
      Map<String,dynamic>boundsSw,
      )async{
    // final double lat=place['geometry']['location']['lat'];
    // final double lng=place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat,lng),
        zoom: 12,
       ),
      ),
    );
    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
          northeast: LatLng(boundsNe['lat'],boundsNe['lng'],),
          southwest:  LatLng(boundsSw['lat'],boundsSw['lng'],),
       ),
      25
      ),
    );
    mapController.showPinsOnMap(  LatLng(lat,lng),  LatLng(lat2,lng2));
    mapController.setPolylines( LatLng(lat,lng),  LatLng(lat2,lng2));
     // mapController.calculateDistanceFunc(loc.latitude,loc.longitude);

  }



  getInoutDecoration(hint, icon) {
    return InputDecoration(
      icon: Container(
        margin: const EdgeInsets.only(
          left: 20,
        ),
        width: 10,
        height: 10,
        child: icon,
      ),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }
}
