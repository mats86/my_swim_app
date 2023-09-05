
import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  const MySquare({super.key, required this.child});
  final String child;


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 100,
          color: Colors.lightBlueAccent,
          child: Text(
            child,
            style: const TextStyle(fontSize: 30),
          )
        )
    );
  }
}