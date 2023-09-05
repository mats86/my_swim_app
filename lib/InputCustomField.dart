
import 'package:flutter/material.dart';

class InputCustomField extends StatelessWidget {
  const InputCustomField({super.key, required this.controller, required this.labelText, required this.validatorText});
  final String labelText;
  final TextEditingController controller;
  final String validatorText;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE0E0E0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(labelText),
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  const Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
          // validator: (value) {
          //   if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
          //     return "Enter correct name";
          //   }else{
          //     return null;
          //   }
          // },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}