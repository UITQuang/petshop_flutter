// @dart=2.9
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:project1/src/ui/home/home.dart';
import 'package:project1/src/ui/login/login.dart';
import 'package:provider/provider.dart';



void main() async{
 await Hive.initFlutter();
   await Hive.openBox('userBox');
   await Hive.openBox('productBox');
  runApp(ChangeNotifierProvider(
    create: (_) => CartProvider(),
    child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.pinkAccent),
        debugShowCheckedModeBanner: false,
        home:  const Homepage()),
  ));

}
