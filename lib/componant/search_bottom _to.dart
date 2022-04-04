import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../screens/maps_screens/controller/map_controller.dart';

class searchBottomTo extends StatelessWidget {
  const searchBottomTo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
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

                       Material(
                          child: Container(
                            margin: EdgeInsets.only(right: 44),
                            height: 60.0,
                            width: double.infinity,
                            decoration: getBoxShadow(),
                            child:
                              TextField(
                              keyboardType: TextInputType.text,
                              controller: controller.searchDesTextEditing,
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

                              }
                                // mapController.searchPlacesTo(value)
                            ),
                          ),
                        ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          child: Container(
                            height: 33.0,
                            width: 50,
                            decoration: getBoxShadow(),
                            child: IconButton(
                              onPressed: () {
                                print(controller.searchController.text);

                              },
                              icon: Icon(Icons.double_arrow_outlined),
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
        margin: EdgeInsets.only(
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
        color: Colors.red,
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
        ]);
  }
}
