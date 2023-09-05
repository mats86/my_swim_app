import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'SignUpScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/WM-Head-BG.jpg"),
        fit: BoxFit.cover),
      ),
    );
  }
}