// @dart=2.9

import 'package:flutter/material.dart';
import 'package:project1/src/providers/Counter.dart';
import 'package:project1/src/ui/cart/Cart.dart';
import 'package:project1/src/ui/payment/After_Pay.dart';
import 'package:project1/src/ui/payment/Payment.dart';
import 'package:project1/src/ui/product/detail_product.dart';
import 'package:project1/src/ui/login/login.dart';
import 'package:project1/src/ui/testp/CounterHome.dart';
import 'package:project1/src/ui/testp/HomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CounterProvider(),
    child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.pinkAccent),
        debugShowCheckedModeBanner: false,
        home: Cart()),
  ));
}
