import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RadarButton extends StatelessWidget {
  final GestureTapCallback onPressed;

  RadarButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.deepPurple,
      splashColor: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            const Icon(
              Icons.explore,
              color: Colors.amber,
            ),
            const SizedBox(width: 8.0),
            const Text(
              "test",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ), onPressed: null,
    );
  }
}
