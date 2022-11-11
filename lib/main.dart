// @dart=2.9

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:project1/src/ui/login/login.dart';

void main() async{
  await Hive.initFlutter();
  var box = await Hive.openBox('userBox');
  runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.pinkAccent),
      debugShowCheckedModeBanner: false,
      home: LoginPage()));
}
