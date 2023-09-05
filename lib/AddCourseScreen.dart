import 'package:flutter/material.dart';
import 'package:my_swim_app/InputCustomField.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();

}

class _AddCourseScreenState extends State<AddCourseScreen> {
  TextEditingController kursName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neuen Schwimmkurs hinzufügen')),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputCustomField(
                controller: kursName,
                  labelText: "Kurs Name", validatorText: '',
              ),
              InputCustomField(
                  controller: kursName,
                  labelText: "Kurs Price", validatorText: '',
              ),
            ],
          ),
        )
      ),
    );
  }
}