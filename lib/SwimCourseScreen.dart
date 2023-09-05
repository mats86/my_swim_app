import 'package:flutter/material.dart';
import 'package:my_swim_app/square.dart';

class SwimCourseScreen extends StatefulWidget {
  const SwimCourseScreen({super.key});

  @override
  State<SwimCourseScreen> createState() => _SwimCourseScreenState();
}

class _SwimCourseScreenState extends State<SwimCourseScreen> {
  final List _swimCourse = [
    'Kurs 1',
    'Kurs 2',
    'Kurs 3'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schwimmkurse')),
      body: ListView.builder(
        itemCount: _swimCourse.length,
          itemBuilder: (context, index) {
            return MySquare(
              child: _swimCourse[index]
            );
          }
      ),
    );
  }
}