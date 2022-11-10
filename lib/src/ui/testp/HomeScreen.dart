import 'package:flutter/material.dart';
import 'package:project1/src/providers/Counter.dart';
import 'package:project1/src/ui/testp/SecondScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<CounterProvider>().getCount().toString(),
              style: TextStyle(fontSize: 50),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(
                    builder: (_)=>SecondScreen()
                ));
              },
              child: Text('Go to second screen'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterProvider>().setCount();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
