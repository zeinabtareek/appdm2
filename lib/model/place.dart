import 'package:animation_uber_user/model/geometry_model.dart';

class Place {
  final Geometry ? geometry;
  final String ? name;
  final String ? vicinity;


  Place({this.geometry,this.name,this.vicinity});
  factory Place.fromJson(Map<String , dynamic> parsedJson){
    return Place(
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name:  parsedJson['name'],
      vicinity: parsedJson['vicinity'],

    );
  }

}