import 'package:animation_uber_user/screens/register_screen/controller/register_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../screens/home_navigation_bar/controller/home_controller.dart';
import '../screens/log_in_screen/controller/log_in_controller.dart';
import '../screens/maps_screens/controller/map_controller.dart';
import '../services/search_service.dart';

class Binding extends Bindings {
  @override
  void dependencies (){
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => LogInController());


  }
}