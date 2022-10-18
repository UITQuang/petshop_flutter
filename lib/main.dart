import 'package:flutter/material.dart';
import 'ui/login/login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.pinkAccent),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

