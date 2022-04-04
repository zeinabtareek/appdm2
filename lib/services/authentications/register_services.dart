 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
class RegisterServices {
  final auth = FirebaseAuth.instance;
  final store = FirebaseDatabase.instance;
  // User? currentFirebaseUser ;
  // final User? currentFirebaseUser;
  Rxn<User> currentFirebaseUser = Rxn<User>();






}
