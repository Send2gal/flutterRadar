import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int counter;

  Counter({this.counter});

  @override
  Widget build(BuildContext context) {
    
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        );
  }
}



