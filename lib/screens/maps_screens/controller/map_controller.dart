import 'dart:async';
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:animation_uber_user/screens/load_screen.dart';
import 'package:animation_uber_user/services/search_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
 import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
 import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../../model/search_suggestion_model.dart';
  class MapController extends GetxController {
  GoogleMapController ?googleMapController;
  final sessionToken=''.obs;
  final ApiKey='AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';


TextEditingController searchController=TextEditingController();
TextEditingController searchDesTextEditing=TextEditingController();


  static  LatLng SOURCE_LOCATION =LatLng(30.020375934687184, 31.23328954878036);
  static LatLng DEST_LOCATION =LatLng(29.986658032558353, 31.231931181107207);
  static  double CAMERA_ZOOM=18;
  static double CAMERA_TILT=80;
  static double CAMERA_BEARING=30;
  static double PIN_VISIBLE_POSITION=20;
  static double PIN_INVISIBLE_POSITION=-300;
  static double SEARCH_VISIBLE_POSITION=20;
  static double SEARCH_INVISIBLE_POSITION=-300;

  CameraPosition initialCameraPOstion =CameraPosition(
    target: LatLng(30.020375934687184, 31.23328954878036),
    zoom: CAMERA_ZOOM,
    bearing: CAMERA_BEARING,
    tilt: CAMERA_TILT,
  );

  BitmapDescriptor ? sourceIcon;
  BitmapDescriptor ? destinationIcon;
  Set<Marker> markers =Set<Marker>();
  LatLng? currentLocation=LatLng(0.0, 0.0);
  LatLng ?pickupPosition ;
   LatLng? destinationLocation;
  Placemark address=Placemark();
  // String ?address;
  String ?subLocality;
  String ?street;
  String ? name;
  String ?locality;
  String ? administrativeArea;
  double? pinPillPosition=PIN_INVISIBLE_POSITION;
  double? searchPillPosition=PIN_INVISIBLE_POSITION;
  double distance = 0.0;
  final check = false.obs;
  final checkOut = false.obs;
  final checkUserBadgetSelected =false.obs;
  final searchresultsfrom=<Suggestion>[].obs;
  final List<Suggestion> predictions=<Suggestion>[];

  StreamController<PlaceDetail>selectedLocation=StreamController<PlaceDetail>();
  StreamSubscription ? locationSubscription;

  Map<String, dynamic>? get place => null;

  Future<void> onInit() async {
  // set initial location
  this.setInitialLocation();
  getCurrentLocation();
  // set up the marker icons
  this.setSourceAndDestinationMarkIcon();
  // show Markers
  this.showPinsOnMap(currentLocation!,destinationLocation!);
  markers;
  checkFun();
  userCheckFunc();

  //set polylines
  this.polylinePoints =PolylinePoints();
  setPolylines(currentLocation!,destinationLocation!);
  polyLines.add(
      Polyline(
          polylineId: PolylineId('polyline'),
          width: 5,
          color: Color(0xFF08A5CB),
          points: listPolyLineCoordinates,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      ),
  );
   getAddressFromLatLng(currentLocation);
  // calculateDistance();
  // calculateDistanceFunc(currentLocation!.latitude,currentLocation!.longitude);
   // goToPlace(PlaceDetail());
  setSelectedLocation(Suggestion(placeId:searchresultsfrom[1].placeId ).placeId.toString());
  }

  @override
  void onClose() {
     selectedLocation.close();
    locationSubscription;
    super.onClose();
  }

  @override
  void dispose() {
    selectedLocation.close();
    locationSubscription!.cancel();

    super.dispose();
  }
  checkFun() {
    check.value = !check.value;
    searchresultsfrom.length=0;
    isChecked(check);
    print(check.value);
    update();
  }

userCheckFunc(){
  checkUserBadgetSelected.value = !checkUserBadgetSelected.value;
   update();
}

  checkOutFunc(){
    checkOut.value = !checkOut.value;
   update();
}


isChecked(check){
try{
  if(check!=null ||checkUserBadgetSelected!=null) {
    pinPillPosition = check != true ?
    PIN_VISIBLE_POSITION :
    PIN_INVISIBLE_POSITION ;
    if(check!=true){
      searchPillPosition=
      SEARCH_INVISIBLE_POSITION;
    }else{
      searchPillPosition= SEARCH_VISIBLE_POSITION;
    }
    update();
  }else{print('error');}
}catch(e){
  throw Exception();
    }
  }

whiteGoogleMapControllerSwitch(controller){
  googleMapController=controller;
 }

blackGoogleMapControllerSwitch(controller){
  googleMapController=controller;
  googleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
 }


setInitialLocation(){
    currentLocation=LatLng(
      SOURCE_LOCATION.latitude,
      SOURCE_LOCATION.longitude
    );
    destinationLocation=LatLng(
      DEST_LOCATION.latitude,
      DEST_LOCATION.longitude
    );
update();

}

setSourceAndDestinationMarkIcon()async{

  sourceIcon=await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio:2.0 ),
    'assets/carIcon.png',
  );
  destinationIcon=await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(
        devicePixelRatio:2.0,
        ),
    'assets/carIcon.png',
  );
}

showPinsOnMap(LatLng point ,LatLng desPoint  ){
  try {
    markers.add(
        Marker(
            markerId: MarkerId('sourcePin'),
            position: point,
            // position: currentLocation!,
            // icon: sourceIcon!,
            infoWindow: InfoWindow(title: locality, snippet: "Pick Up Locaation"),
            onTap: () {
              try {
                userCheckFunc();
                print(currentLocation!.latitude);
                update();
              } catch (e) {
                printError(info: '#####################');
              }
            }
        )
    );

    markers.add(
        Marker(
            markerId: MarkerId('destinationPin',),
            position: desPoint,
            // icon: destinationIcon!,
            onTap: () {
              try {
                checkFun();
                print('first marker');
                update();
              } catch (e) {
                printError(info: '#####################');
              }
            }
        ));
    setPolylines(point,desPoint);
    // calculateDistanceFunc(currentLocation!.latitude,currentLocation!.longitude);
    update();
  }catch(e){
    printError(info: '############no#########');
  }

}




/*************************CURRENTLOCATION*********************************/
  Completer<GoogleMapController> _controller = Completer();

  void getCurrentLocation() async{

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
   return await Geolocator.getCurrentPosition().then((currLocation) {

     currentLocation =
        LatLng(currentLocation!.latitude, currLocation.longitude);
     getAddressFromLatLng(currentLocation);
          print(currLocation.longitude);
          pickupPosition=currentLocation;
       update();
    });
  }
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentLocation!,
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
      ),
    ));update();
  }

  onCameraMove(CameraPosition position) {
    currentLocation = position.target;
     update();
  }

  getAddressFromLatLng(currentLocation) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,

      );

      // calculateDistanceFunc(currentLocation.latitude,
      //   currentLocation.longitude,);
      //
      //
      Placemark place = placemarks[0];
      address.country!=place.country;
      subLocality=place.subLocality;
      street=place.street;
      name=place.name;
      locality=place.locality;
      administrativeArea=place.administrativeArea;
       print('$address'+'$currentLocation');
       //get the search input
      // searchInputTextEditing.text=placemarks[0].name!;

      update();
    } catch (e) {
      print(e);
    }
  }

  /*************************PolyLineController*********************************/
  Set<Polyline> polyLines=Set<Polyline>();
  final listPolyLineCoordinates =<LatLng>[].obs;
  // List<LatLng> listPolyLineCoordinates=[];
  PolylinePoints polylinePoints = PolylinePoints();

  setPolylines(LatLng point, LatLng desPoint)async{
    PolylineResult result=await polylinePoints.getRouteBetweenCoordinates(
       ApiKey,
       PointLatLng(
         point.latitude,
         point.longitude,
        //  currentLocation!.latitude,
        // currentLocation!.longitude,
        ),
      PointLatLng(
        desPoint.latitude,
        desPoint.longitude,
        // destinationLocation!.longitude,
       ),
      travelMode: TravelMode.driving,

    );print("my points");
    print(result.points);

    // calculateDistanceFunc(currentLocation!.latitude,currentLocation!.longitude);
    if(result.status =='OK'&& result.points.isNotEmpty){
      listPolyLineCoordinates.value = [];
      result.points.forEach((PointLatLng point) {
        listPolyLineCoordinates.add(
            LatLng(
                point.latitude,
                point.longitude,
            ));
        polyLines.add(
          Polyline(
            polylineId: PolylineId('polyline'),
            width: 10,
            color: const Color(0xFF08A5CB),
            points: listPolyLineCoordinates,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap,
          ),
        );
        update();
      });
    }else{
      printError(info: '((((((((((((((((((((((((');
    }
    calculateDistance(point.latitude ,point.longitude ,desPoint.latitude,desPoint.longitude);
    calculateDistanceFunc(point);
    // calculateDistanceFunc( currentLocation!.latitude,currentLocation!.longitude);
    update();
  }
/*************************another way to calcualte the distanse*********************************/
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  calculateDistanceFunc(currentLocation) async{

    double totalDistance = 0;
    for(var i = 0; i < listPolyLineCoordinates.length-1; i++){
      // currentLocation=listPolyLineCoordinates;
       totalDistance += calculateDistance(
           listPolyLineCoordinates[i].latitude,
           listPolyLineCoordinates[i].longitude,
          listPolyLineCoordinates[i+1].latitude,
          listPolyLineCoordinates[i+1].longitude);
    }
    print(totalDistance);
    // setState(() {
      distance = totalDistance;
    update();

    return await distance;

  }
/*****************************--***************************************/
   var distInMeters;

  // calculateDistanceFunc(double lat1,double long1  ) async{
  //   // final distanceInMeters = GeolocatorPlatform.instance.distanceBetween();
  //   final distanceInMeters= await
  //   GeolocatorPlatform.instance.distanceBetween(
  //     lat1,
  //     long1,
  //     DEST_LOCATION.latitude,
  //     // setPolylines
  //     DEST_LOCATION.longitude,
  //   );
  //   print('total distnation is $distanceInMeters ${DEST_LOCATION.longitude}${lat1}');
  //   update();
  //   distance = distanceInMeters;
  //   return distance;
  // }

  /*************************SEARCHController*********************************/

  SearchServices searchServices=SearchServices();

  final name2 = 'value'.obs;

  onPickupTextFieldChanged(String searchTerm )async{

   if (searchTerm.isEmpty) {
     searchresultsfrom == null;
   } else {
     try {
       await searchServices.getAutoCompletefrom(searchTerm).then((predictions) {
         updatePickupPointSuggestions(predictions);
          });
       update();

     } catch (e) {
       print(e);
     }
    update();
   return searchresultsfrom;
 }
 }

  updatePickupPointSuggestions(List<Suggestion> predictions) {
      searchresultsfrom.value = predictions;
    update();
  }

  onPickupPredictionItemClick(Suggestion sugg) async {
    updatePickupPointSuggestions( predictions);
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(37.43296265331129, -122.08832357078792),
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
      ),


    )
    );
    update();  }

  searchPlacesfrom(String searchTerm )async{
  searchresultsfrom.value=  await searchServices.getAutoCompletefrom(searchTerm);
   update();
   return searchresultsfrom;
 }

  setSelectedLocation(String placeId)async{
   selectedLocation.add(await searchServices.getPlaceDetails(placeId));
  print('this is the dropp offf locatiom'+ selectedLocation.toString());
  update();
   searchresultsfrom==null;
  return selectedLocation;

   }
   remove(){
     searchresultsfrom.length=0;
   update();
   }

 }