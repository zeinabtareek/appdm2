
import 'package:animation_uber_user/screens/load_screen.dart';
import 'package:animation_uber_user/screens/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(
      child:  GetMaterialApp(
      title: 'Flutter Demo',
      home: LoadingScreen(),
      // home: test(),
      debugShowCheckedModeBanner: false,
  )));
}

class MyApp extends StatefulWidget {
  MyApp({this.child});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findRootAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      child: widget.child!,
      key: key,
    );
  }
}
// import 'dart:async';
//
// import 'package:animation_uber_user/screens/maps_screens/controller/map_controller.dart';
// import 'package:animation_uber_user/services/search_service.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import 'componant/map_bottom_pill.dart';
// import 'componant/map_user_container.dart';
// import 'componant/serch_bottom_field.dart';
// import 'componant/user_image_circle.dart';
// import 'constant/constant.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: MapSample(),
//     );
//   }
// }
//
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return new  GetBuilder<MapController>(
//         init :MapController(),
//     builder:(controller)=>  Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: const Icon(
//           Icons.menu, color: K.mainColor,
//           size: 25,
//         ),
//         title:   Center(
//           child: Image.asset('assets/logo22.png',
//             width: 150,
//           ),),
//         elevation: 0.0,
//         iconTheme: const IconThemeData(
//           color: K.mainColor,
//         ),actions: [
//         Opacity(opacity:1,
//           child: Container(
//             margin: EdgeInsets.only(right: 10),
//             padding: EdgeInsets.all(10),
//             child:UserImageCircle(
//               isSelected:controller.checkUserBadgetSelected.value,
//             ),
//           ),
//         )
//       ],),
//       body: Stack(children: [
//
//       Positioned.fill(
//       child:GoogleMap(
//         mapType: MapType.normal,
//         markers: controller.markers,
//         onCameraMove: controller.onCameraMove,
//         polylines: Set<Polyline>.of(controller.polyLines),
//         initialCameraPosition: controller.initialCameraPOstion,
//         onMapCreated: (GoogleMapController gcontroller) {
//     controller.blackGoogleMapControllerSwitch(gcontroller);
//     controller.showPinsOnMap();
//     controller.setPolylines();
//           _controller.complete(gcontroller);
//         },
//       ), ),
//       Positioned(
//           top: 100,
//           left: 0,
//           right: 0,
//           child:
//           MapUserContainer(
//             isSelected:controller.checkUserBadgetSelected.value,
//           )),
//
//
//
//       Positioned(
//         top: 140,
//         left: 0,
//         right: 0,
//         child:
//         GetBuilder<MapController>(
//             init :MapController(),
//             builder:(controller) {
//               if((controller.searchresultsfrom!=null && controller.searchresultsfrom.length!=0) ) {
//                 return Container(
//                   // padding: EdgeInsets.all(3),
//                   height: 700,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: K.BlackColor.withOpacity(.6),
//                       backgroundBlendMode: BlendMode.darken
//                   ),
//                   child: Obx(()=>ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       // scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       itemCount: controller.searchresultsfrom.length,
//                       itemBuilder: (context ,index){
//                         return  GetBuilder<MapController>(
//                             init :MapController(),
//                         builder:(controller) =>ListTile(
//                             title: Text(
//                               controller.searchresultsfrom[index].description.toString(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             onTap: () async{
//                               controller.checkFun();
//                               var place=await SearchServices().getPlace(controller.searchController.text);
//                               await  goToPlace(place);
//                             })
//                         );
//                       }
//                   ),
//                   ),
//                 );
//               }else{
//                 return Container();
//               }
//             }
//         ),
//       ),
//       AnimatedPositioned(
//           left: 0,
//           right: 0,
//           bottom: controller.pinPillPosition,
//           duration: Duration(milliseconds: 700),
//           curve: Curves.easeIn,
//           child: MapBottomPill()
//       ),
//       GetBuilder<MapController>(
//         init :MapController(),
//         builder:(controller) => AnimatedPositioned(
//           left: 0,
//           right: 0,
//           bottom: controller.searchPillPosition,
//           duration: Duration(milliseconds: 700),
//           curve: Curves.easeIn,
//           child:Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(20),
//             child:
//               TextFormField(
//                 // keyboardType: TextInputType.text,
//                   textCapitalization: TextCapitalization.words,
//                   controller: controller.searchController ,
//                   // controller: controller.searchInputTextEditing ,
//                   // textInputAction: TextInputAction.next,
//                   cursorColor: Colors.black,
//                   decoration: getInoutDecoration(
//                     "pick up Location?",
//                     const Icon(
//                       Icons.location_on,
//                       color: Colors.green,
//                     ),
//                   ),
//                   onChanged: (value) {
//                     controller.searchPlacesfrom(value);
//                     print(value);
//                   }
//
//               ),
//             ),
//             ),
//             ),
//
//
//
//       ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           label: Text('To place!'),
//           icon: Icon(Icons.directions_boat),
//         onPressed: ()async{
//           var place=await SearchServices().getPlace(controller.searchController.text);
//           await  goToPlace(place);
//           // onPressed: _goToTheLake,
//
//         }
//       ),
//       ),
//     );
//   }
//
//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
//
//   Future<void> goToPlace(Map<String ,dynamic>place)async{
//     final double lat=place['geometry']['location']['lat'];
//     final double lng=place['geometry']['location']['lng'];
//      final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(
//       CameraPosition(
//         target: LatLng(lat,lng),
//         zoom: 12,
//
//       ),
//     ),
//     );
//    }
//
//
//   getInoutDecoration(hint, icon) {
//     return InputDecoration(
//       icon: Container(
//         margin: const EdgeInsets.only(
//           left: 20,
//         ),
//         width: 10,
//         height: 10,
//         child: icon,
//       ),
//       hintText: hint,
//       border: InputBorder.none,
//       contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//     );
//   }
//
// }