import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

import 'InputCustomField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.

  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IconStepper Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                icons: const [
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                  Icon(Icons.access_alarm),
                  Icon(Icons.supervised_user_circle),
                  Icon(Icons.flag),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              header(),
              Expanded(
                child: Center(
                  child: body(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: activeStep < upperBound ? const Text('Weiter') : const Text('Kostenpflichtig buchen') ,
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        } else {
          Navigator.pop(context);
        }
      },
      child: activeStep > 0 ? const Text('Zurück') : const Text('Abrechen'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0: // activeStep minus 1
        return 'Preface 1';

      case 1: // activeStep minus 1
        return 'Table of Contents 2';

      case 2: // activeStep minus 1
        return 'About the Author 3';

      case 3: // activeStep minus 1
        return 'Publisher Information 4';

      case 4: // activeStep minus 1
        return 'Reviews 5';

      default:
        return 'Error';
    }
  }

  Widget body() {
    switch (activeStep) {
      case 0: // activeStep minus 1
        return stepOne();

      case 2: // activeStep minus 1
        return stepTow();

      case 3: // activeStep minus 1
        return stepThree();

      case 4: // activeStep minus 1
        return stepFour();

      case 5: // activeStep minus 1
        return stepFive();

      default:
        return const Column();
    }
  }

  Widget stepOne() {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        InputCustomField(
          controller: firstName,
          labelText: "Vorname des Schwimmschülers", validatorText: '',
        ),
        InputCustomField(
          controller: lastName,
          labelText: "Nachname des Schwimmschülers", validatorText: '',
        ),
        TextField(
          controller: birthday,
          decoration: const InputDecoration(
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text("Geburtstag des Kindes"),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            border: OutlineInputBorder(),
          ),
          readOnly: true,
          onTap: () async {
            BottomPicker.date(
              title: "Bitte gib das Geburtsdatum deines Kindes ein",
              titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue
              ),
              onChange: (date) {
                // print(date);
              },
              onSubmit: (date) {
                setState(() {
                  // _swimmerAge = AgeCalculator.age(
                  //     DateTime.parse(
                  //         DateFormat('yyyy-MM-dd').format(date)));
                  // birthday.text = DateFormat('dd.MM.yyyy').format(date);
                });
              },
            ).show(context);
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget stepTow() {
    return const Column();
  }

  Widget stepThree() {
    return const Column();
  }

  Widget stepFour() {
    return const Column();
  }

  Widget stepFive() {
    return const Column();
  }
}