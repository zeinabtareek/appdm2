//
//
//
//
import 'dart:async';

import 'package:animation_uber_user/model/search_suggestion_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
  import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'as convert;
import '../constant/constant.dart';

import 'package:geolocator/geolocator.dart';

class SearchServices {
   Completer<GoogleMapController> _controller = Completer();

Future<List<Suggestion>> getAutoCompletefrom(String search)async{
  // K.googleKeyAPi;
  var url='https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=%28cities%29&key=${K.googleKeyAPi}';
  var response =await http.get(Uri.parse(url));
  var json=convert.jsonDecode(response.body);
  var jsnResults=json['predictions'] as List;
  return jsnResults.map((place) => Suggestion.fromJson(place)).toList();
 }

Future< String  >getPlaceId(String input)async{
  var url='https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=${K.googleKeyAPi}';
  var response=await http.get(Uri.parse(url));
  var json=convert.jsonDecode(response.body);
  var placeId=json['candidates'][0]['place_id'] as String;
  print(placeId);
  return placeId;

}
Future<Map<String, dynamic>>getPlace(String input)async{
  final placeId= await getPlaceId(input);
  var url='https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${K.googleKeyAPi}';
  var response=await http.get(Uri.parse(url));
  var json=convert.jsonDecode(response.body);
  var results=json['result'] as Map<String,dynamic>;
  print(results);
  return results;
}
Future <Map<String, dynamic>>getDirections(String origin ,String des)async{
  var url=
  'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$des&key=${K.googleKeyAPi}';
   var response=await http.get(Uri.parse(url));
  var json=convert.jsonDecode(response.body);
  var results ={
    'bounds_ne':json['routes'][0]['bounds']['northeast'],
    'bounds_sw':json['routes'][0]['bounds']['southwest'],
    'start_location':json['routes'][0]['legs'][0]['start_location'],
    'end_location':json['routes'][0]['legs'][0]['end_location'],
    'polyline':json['routes'][0]['overview_polyline']['points'],
    'polyline_decoded':PolylinePoints()
    .decodePolyline(json['routes'][0]['overview_polyline']['points'],)

  };
  print(results);
  return results;  // return results;
}

/*********not needed till now************/
Future<PlaceDetail>getPlaceDetails(String placeId  )async{
  String placeDetailsUrl=
  'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${K.googleKeyAPi}';
  // 'https://maps.googleapis.com/maps/api/place/details/json?place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
  var response =await http.get(Uri.parse(placeDetailsUrl));
  var json=convert.jsonDecode(response.body);
  var jsnResults=json['result'] as Map<String, dynamic>;
  return PlaceDetail.fromJson(jsnResults);
}

Future<String> getPlaceNameFromLatLng(LatLng latLng) async {
  List<Placemark> placemark = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
  return placemark[0].name.toString() + ", " +
      placemark[0].locality.toString() +
      ", " +
      placemark[0].country.toString();
}




// Future<LatLng> getLatLngFromAddress(Position address) async {
//   // List<Placemark> list = await Geolocator().placemarkFromAddress(address);
//   List<Placemark> list = await placemarkFromCoordinates(address);
//   return LatLng(list[0].position.latitude, list[0].position.longitude);
// }



}






