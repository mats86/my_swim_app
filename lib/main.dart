import 'package:flutter/material.dart';
import 'package:my_swim_app/AddSwimPoolScreen.dart';
import 'package:my_swim_app/SwimPoolScreen.dart';

import 'AddCourseScreen.dart';
import 'LoginScreen.dart';
import 'SignUpScreen.dart';
import 'SwimCourseScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Schwimmschule Allgäu'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/cropped-Logo-Wassermenschen.png"),
          )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/WM-Head-BG.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                },
                child: const Text('Schwimmkurs buchen'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCourseScreen()));
                },
                child: const Text('Add Kurs'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SwimCourseScreen()));
                },
                child: const Text('Schwimmkurse'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddSwimPoolScreen()));
                },
                child: const Text('Add Schwimmbad'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SwimPoolScreen()));
                },
                child: const Text('Schwimmbad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

