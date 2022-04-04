import 'dart:async';

import 'package:animation_uber_user/screens/test.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant/constant.dart';
import '../screens/maps_screens/controller/map_controller.dart';
import '../services/search_service.dart';

class searchBottom extends StatelessWidget {
  CarouselController carouselController = CarouselController();
  MapController mapController = Get.put(MapController());

  searchBottom({
    Key? key,
  }) : super(key: key);

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: K.BlackColor.withOpacity(.2),
                blurRadius: 10,
                offset: Offset.zero)
          ]),
      child: GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) => Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CarouselSlider(
                          carouselController: carouselController,
                          // Give the controller
                          options: CarouselOptions(
                            height: 75,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                          ),
                          items: [
                            Material(
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 60.0,
                                  width: double.infinity,
                                  decoration: getBoxShadow(),
                                  child: Row(children: [
                                    Expanded(
                                      child: TextFormField(
                                          // keyboardType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controller:
                                              mapController.searchController,
                                          // controller: controller.searchInputTextEditing ,
                                          // textInputAction: TextInputAction.next,
                                          cursorColor: Colors.black,
                                          decoration: getInoutDecoration(
                                            "pick up Location?",
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.green,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            mapController
                                                .searchPlacesfrom(value);
                                            print(value);
                                          }
                                          ),
                                    ),
                                  ])),
                            )
                          ],
                        ),
                        // searchButton(),
                        searchTo(),
                        Visibility(
                          visible: mapController.distance == null ? false : true,
                          child: Text(
                            'DISTANCE: ${mapController.distance.toStringAsFixed(2)} km',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  getBoxShadow() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
        ]);
  }

  searchTo(){
    return Material(
      child: Container(
        margin: EdgeInsets.all(10),
        height: 60.0,
        width: double.infinity,
        decoration: getBoxShadow(),
        child: TextField(
            keyboardType: TextInputType.text,
            controller: mapController.searchDesTextEditing,
            cursorColor: Colors.black,
            // textInputAction: TextInputAction.go,
            decoration: getInoutDecoration(
              "destination?",
              const Icon(
                Icons.local_taxi,
                color: Colors.black,
              ),
            ),
            onChanged: (value) {
              mapController
                  .searchPlacesfrom(value);
              print(value);
            }
            // onChanged: (value) {}
            // mapController.searchPlacesTo(value)
            ),
      ),
    );
  }

  searchButton() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('go'),
          Container(
            height: 27.0,
            width: 50,
            child: IconButton(
              onPressed: () {
                carouselController.nextPage();
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ),
        ]);
  }
}
