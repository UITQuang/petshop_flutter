// @dart=2.9
import 'package:flutter/material.dart';
import 'package:project1/src/ui/login/login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.pinkAccent),
    debugShowCheckedModeBanner: false,
    home: DetailProductScreen(),
  ));
}
