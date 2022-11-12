// @dart=2.9
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:project1/src/models/product_detail.dart';

import 'package:project1/src/providers/cart_provider/CartProvider.dart';
import 'package:project1/src/ui/cart/Cart.dart';
import 'package:project1/src/ui/home/home.dart';
import 'package:project1/src/ui/payment/After_Pay.dart';
import 'package:project1/src/ui/payment/Payment.dart';
import 'package:project1/src/ui/product/detail_product.dart';
import 'package:project1/src/ui/login/login.dart';
import 'package:provider/provider.dart';



void main() async{
 await Hive.initFlutter();
  var box = await Hive.openBox('userBox');
  var productBox = await Hive.openBox('productBox');
  runApp(ChangeNotifierProvider(
    create: (_) => CartProvider(),
    child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.pinkAccent),
        debugShowCheckedModeBanner: false,
        home: Homepage()),
  ));

}
