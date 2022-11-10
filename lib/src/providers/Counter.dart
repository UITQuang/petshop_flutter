import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier {
  int _counter = 10;

  int getCount() => _counter;

  void setCount(){
    _counter = _counter + 1;
  notifyListeners();
  }
}