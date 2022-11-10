import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/src/providers/Counter.dart';
import 'package:provider/provider.dart';

class CounterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.watch<CounterProvider>().getCount().toString(),
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.read<CounterProvider>().setCount();
        },
      ),
    );
  }
}
