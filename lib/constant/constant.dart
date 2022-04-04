import 'package:flutter/material.dart';

class K{

  static const googleKeyAPi='AIzaSyCzuhU5w3Ah8t2x2pIKXzsGoATsdzVNK9I';

  static const mainColor = Color(0xFF953333);
  static const secondColor = Colors.white;
  static const BlackColor = Color(0xFF090909);
  static const IconColor = Colors.grey;
  static const TextFieldColor = Color(0xFFfafafa);

  static const textFieldDecoration = InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: K.BlackColor),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          )));
  static const textFieldDecorationEdit = InputDecoration();
  static const textFieldSearchDecoration = InputDecoration(
    prefixIcon: Icon(
      Icons.search_outlined,
      size: 30,
      color: K.IconColor,
    ),
    suffixIcon: Icon(
      Icons.menu,
      size: 30,
      color: K.IconColor,
    ),
    filled: true,
    fillColor: K.TextFieldColor,
    hintText: "Find food or Restaurant",
    hintStyle: TextStyle(fontSize: 18, color: K.IconColor),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: K.IconColor),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
  );

}