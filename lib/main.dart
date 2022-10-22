// @dart=2.9
import 'package:flutter/material.dart';
import 'src/screen/ui/login/login.dart';
import 'src/screen/detail_product.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.pinkAccent),
    debugShowCheckedModeBanner: false,
    home: DetailProductScreen(),
  ));
}
