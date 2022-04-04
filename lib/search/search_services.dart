//
//
//
// import 'package:animation_uber_user/search/search_model.dart';
// import 'package:dio/dio.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class TrafficService {
//   TrafficService._privateConstructor();
//   final ApiKey='AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';
//
//   static final TrafficService _instance = TrafficService._privateConstructor();
//   factory TrafficService() {
//     return _instance;
//   }
//   final _dio = new Dio();
//   final _baseUrlDir = "https://api.mapbox.com/directions/v5";
//   final _baseUrlGeo = "https://api.mapbox.com/geocoding/v5";
//
//   Future<SearchResponse> getResultadosPorQuery(String searchWord, LatLng proximidad) async {
//     final url = "${_baseUrlDir}/mapbox.places/$searchWord.json";
//     try {
//       final resp = await this._dio.get(
//         url,
//         queryParameters: {
//           "access_token": this.ApiKey,
//           "autocomplete": "true",
//           "proximity": "${proximidad.longitude},${proximidad.latitude}",
//           "language": "es",
//         },
//       );
//
//       return searchResponseFromJson("${resp.data}");
//     } catch (e) {
//       return SearchResponse(features: [], attribution: "", query: [], type: "");
//     }
//    }
//   }
