import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:my_swim_app/Customer.dart';
import 'package:my_swim_app/InputCustomField.dart';
import 'package:my_swim_app/logic/models/mysql.dart';

import 'CustomerDetails.dart';

List<String> sisonList = <String>['Laufender Sommer', 'Kommender Sommer'];
List<String> titleList = <String>['Herr', 'Frau', 'Divers'];

List<Course> _courseList = [];
List<SwimmingPool> _swimmingPoolsList = [];
List<SwimPoolCheckbox> _swimPoolCheckbox = [];
dynamic _swimmingCourses, _swimmingPools;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  List<String> fixTermine = [
    'Test1',
    'Test2',
    'Test3',
  ];
  bool _isVisibleFixTermine = false;

  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.

  final _customer = Customer();
  final int _activeStepIndex = 0;

  late String selectedItem;
  String dropdownValue = sisonList.first;
  String dropdownTitleValue = titleList.first;

  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController lastNameParents = TextEditingController();
  TextEditingController firstNameParents = TextEditingController();
  TextEditingController streetAddress = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();

  late DateDuration _swimmerAge;

  @override
  void initState() {
    _getCustomer('select * from swim_db.kurs;');
    _getSwimmingPools('select * from swim_db.schwimmbad');
    super.initState();
  }

  var db = Mysql();

  _getCustomer(String sql) async {
    db.getConnection().then((conn) async {
      _swimmingCourses = await conn.query(sql);
    });
  }

  _getSwimmingPools(String sql) async {
    db.getConnection().then((conn) async {
      _swimmingPools = await conn.query(sql);
      _swimmingPoolsList = [];
      List<OpenTime> openTime;
      for (var row in _swimmingPools) {
        openTime=(json.decode(row[4].toString()) as List).map((i) =>
            OpenTime.fromJson(i)).toList();
        _swimmingPoolsList.add(
          SwimmingPool(
              schwimmbadID: row[0],
              name: row[1],
              adresse: row[2],
              telefonnummer: row[3],
              oeffnungszeiten: openTime
          )
        );
        _swimPoolCheckbox.add(SwimPoolCheckbox(
            isSelected: false,
            title: row[1].toString(),
            subTitle: row[2].toString()));
      }
    });
  }

  _getAvailableCourse() {
    _courseList = [];
    for (var row in _swimmingCourses) {
      int minAlter, maxAlter;
      minAlter = int.parse(row[8].toString().split('_')[0].replaceAll("+", ""));
      maxAlter = int.parse(row[8].toString().split('_')[1]);
      if(_swimmerAge.years.clamp(minAlter, maxAlter) == _swimmerAge.years){
        _courseList.add(
            Course(
                kursID: row[0],
                kursName: row[2],
                kursPrice: row[4],
                kursBeschreibung: row[5],
                minAlter: row[8].toString().split('_')[0],
                maxAlter: row[8].toString().split('_')[1],
                kursDauer: row[10]
            )
        );
      } else {
        //
      }
    }
    selectedItem = _courseList.first.kursName;
  }

  _setOpenTime() async {
    var result = await db.getConnection().then((conn) {
      List<OpenTime> lot = [];
      lot.add(OpenTime("Mo", "09:00", "17:00"));
      lot.add(OpenTime("Di", "09:00", "17:00"));
      lot.add(OpenTime("Mi", "09:00", "17:00"));
      lot.add(OpenTime("Do", "09:00", "17:00"));
      lot.add(OpenTime("Fr", "09:00", "17:00"));
      lot.add(OpenTime("Sa", "09:00", "17:00"));
      lot.add(OpenTime("So", "09:00", "17:00"));
      String sql = 'insert into Schwimmbad '
          '(Name, Adresse, Telefonnummer, Oeffnungszeiten) values (?, ?, ?, ?)';
      conn.query(sql, ["Schwimmbad", "Schwimm Straße 11, 88032 Bad", "0123456789", jsonEncode(lot)]);
    });
  }

  _setCustomer(Customer customer) async
  {
    var result = await db.getConnection().then((conn) {
      String sql = 'insert into users (name, email, age) values (?, ?, ?)';
      return conn.query(sql, [customer.firstName, customer.email, 6]);
    });
    print('Inserted row id=${result.insertId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Neukunden Anmeldung'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/cropped-Logo-Wassermenschen.png"),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              IconStepper(
                icons: const [
                  Icon(Icons.child_care),
                  Icon(Icons.flag),
                  Icon(Icons.view_timeline),
                  Icon(Icons.family_restroom),
                  Icon(Icons.summarize),
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
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      body(),
                    ],
                  ),
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
        if (_formKey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );

          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
            if(activeStep == 1){
              _getAvailableCourse();
            }
          }
          else if(_activeStepIndex == upperBound) {
            setState(() {
              _customer.firstName = firstName.text;
              _customer.lastName = lastName.text;
              _customer.birthday = birthday.text;
              _customer.email = email.text;

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerDetails(data: _customer.firstName)));
            });
          }
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
        // color: Colors.orange,
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

      case 1: // activeStep minus 1
        return stepTow();

      case 2: // activeStep minus 1
        return stepThree();

      case 3: // activeStep minus 1
        return stepFour();

      case 4: // activeStep minus 1
        return stepFive();

      default:
        return const Column();
    }
  }

  Widget stepOne() {
    return Column(
      children: [
        InputCustomField(
          controller: firstName,
          labelText: "Vorname des Schwimmschülers",
          validatorText: 'firstName',
        ),
        InputCustomField(
          controller: lastName,
          labelText: "Nachname des Schwimmschülers",
          validatorText: 'lastName',
        ),
        TextField(
          controller: birthday,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE0E0E0),
            label: const FittedBox(
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
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
                  _swimmerAge = AgeCalculator.age(
                      DateTime.parse(
                          DateFormat('yyyy-MM-dd').format(date)));
                  birthday.text = DateFormat('dd.MM.yyyy').format(date);
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
    return Form(
      child: Column(
        children: [
          InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0),
                labelText: 'Für welche Sommer-Saison möchtest du den Kurs buchen?',
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              child:DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      items: sisonList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      })
              )
          ),
          const SizedBox(
            height: 32,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "Dem Alter entsprechende Kurse"
            ),
          ),
          const Divider(),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _courseList.length,
              itemBuilder: (context, index){
                return SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged),
                      // ListTile(),
                      Radio(
                          groupValue: selectedItem,
                          value: _courseList[index].kursName,
                          // title: Text(_swimPoolCheckbox[index].title),
                          //subtitle: Text(_swimPoolCheckbox[index].subTitle),
                          onChanged: (val){
                            setState(() {
                              selectedItem = val.toString();
                            });
                          },
                        ),
                      Text('${_courseList[index].kursName} '
                          '${_courseList[index].kursPrice} '
                          '€'),
                      IconButton(
                        onPressed: () => showCourseDescription(context, index),
                        icon: const Icon(
                          Icons.info_rounded,
                          color: Colors.blue,
                          size: 20,
                        ),
                      )
                    ],
                  ),

                );
              }
          ),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "¹ Eine Kursübersicht über all unsere von uns angebotenen Kurse."
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget stepThree() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "Welche Bäder kommen für dich in Frage? *"
          ),
        ),
        const Divider(),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _swimPoolCheckbox.length,
            itemBuilder: (context, index){
              return SizedBox(
                height: 30,
                child: CheckboxListTile(
                    value: _swimPoolCheckbox[index].isSelected,
                    title: Text(_swimPoolCheckbox[index].title),
                    //subtitle: Text(_swimPoolCheckbox[index].subTitle),
                    onChanged: (val){
                      setState(() {
                        _swimPoolCheckbox[index].isSelected = val!;
                      });
                      if(_swimPoolCheckbox[0].isSelected) {
                        _isVisibleFixTermine = true;
                      }
                      if(_swimPoolCheckbox[1].isSelected) {
                        fixTermine.add('value');
                      }
                      else {
                        fixTermine.remove('value');
                      }
                    }
                    ),
              );
            }
        ),
        const Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: fixTermine.length,
          itemBuilder: (BuildContext context, int index) {
            return Visibility(
              visible: _isVisibleFixTermine,
              child: SizedBox(
                height: 30,
                child: Radio(
                    value: fixTermine[index],
                    onChanged: (val){
                      setState(() {

                      });
                    },
                  groupValue: fixTermine[0]),
              ),
            );
          },

        ),
      ],
    );
  }

  Widget stepFour() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(24.0),
                  color: const Color(0xFFE0E0E0)
              ),
              padding: const EdgeInsets.fromLTRB(16.0,0,16.0,0),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                      dropdownColor: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(24.0),
                      isExpanded: true,
                      value: dropdownTitleValue,
                      items: titleList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownTitleValue = value!;
                        });
                      })
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            InputCustomField(
              controller: firstNameParents,
              labelText: "Vorname des Erziehungsberechtigten",
              validatorText: 'firstName',
            ),
            InputCustomField(
              controller: lastNameParents,
              labelText: "Nachname des Erziehungsberechtigten",
              validatorText: 'lastName',
            ),
            InputCustomField(
              controller: streetAddress,
              labelText: "Straße",
              validatorText: 'lastName',
            ),
            InputCustomField(
              controller: houseNumber,
              labelText: "Hausnummer",
              validatorText: 'lastName',
            ),
            InputCustomField(
              controller: zipCode,
              labelText: "PLZ",
              validatorText: 'lastName',
            ),
            InputCustomField(
              controller: city,
              labelText: "Ort",
              validatorText: 'lastName',
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-mail *',
                validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'E-Mail-Bestätigung *',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            IntlPhoneField(
              controller: phoneNumber,
              decoration: const InputDecoration(
                labelText: 'Telefonnummer *',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'DE',
              languageCode: 'DE',
              onChanged: (phoneNumber) {
                setState(() {
                  _customer.phoneNumber = phoneNumber.completeNumber;
                  _customer.whatsappNumber = phoneNumber.completeNumber;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget stepFive() {
    return const Column();
  }

  Future<String?> showCourseDescription(BuildContext context, int index) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Kurs Beschreibung'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      'Kurs Name: ${_courseList[index].kursName}', textAlign: TextAlign.left,),
                    Text('Kurs Price: ${_courseList[index].kursPrice} €', textAlign: TextAlign.right,),
                  ],
                )
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class SwimPoolCheckbox {
  final String title, subTitle;
  bool isSelected;

  SwimPoolCheckbox({required this.isSelected, required this.title, required this.subTitle});
}
