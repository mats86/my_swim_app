
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'InputCustomField.dart';
import 'InputField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
enum LoginResult {
  success,
  failure,
}
class _LoginScreenState extends State<LoginScreen> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.

  int upperBound = 4; // upperBound MUST BE total number of icons minus 1.

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> registerUser() async {
    const String serverUrl = 'http://10.0.2.2:5000'; // Ersetze dies durch die URL deines Servers

    final user = User(username.text, password.text);
    final body = jsonEncode(user.toJson());

    try {
      final response = await http.post(
        Uri.parse('$serverUrl/registerUser'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body
      );
      print(jsonDecode(response.body));
      print(jsonDecode(response.body)['error']);
      if (response.statusCode == 200) {
        print('Benutzer erfolgreich hinzugefügt.');
      } else {
        print('Fehler beim Hinzufügen des Benutzers: ${response.statusCode}');
      }
    } catch (e) {
      print('Fehler beim Hinzufügen des Benutzers: $e');
    }
  }

  Future<bool> checkUser() async {
    const String serverUrl = 'http://10.0.2.2:5000'; // Ersetze dies durch die URL deines Servers

    final user = User(username.text, password.text);
    final body = jsonEncode(user.toJson());

    final response = await http.post(
        Uri.parse('$serverUrl/checkUsername'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body
    );

    if (response.statusCode == 200) {
      // Der BenutzerName ist verfügbar
      return true;
    } else if (response.statusCode == 400) {
      // Der BenutzerName ist bereits vergeben
      return false;
    } else {
      // Ein Fehler ist aufgetreten
      throw Exception('Fehler beim Überprüfen des BenutzerNamens.');
    }
  }

  Future<void> loginUser() async {
    const String serverUrl = 'http://10.0.2.2:5000'; // Ersetze dies durch die URL deines Servers

    final user = User(username.text, password.text);
    final body = jsonEncode(user.toJson());

    try {
      final response = await http.post(
        Uri.parse('$serverUrl/loginUser'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: body,
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        // Erfolgreiche Anmeldung
        print('Anmeldung erfolgreich.');
      } else if (response.statusCode == 401) {
        // Ungültige Anmelde Informationen
        print('Ungültige Anmelde Informationen.');
      } else {
        // Anderer Fehler
        print('Fehler beim Anmelden: ${response.statusCode}');
      }
    } catch (e) {
      // Netzwerk Fehler oder andere Ausnahmen
      print('Fehler beim Anmelden: $e');
    }
  }


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
              InputField(
                controller: username,
                labelText: 'Username',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autoFocus: true,
                  // validatorText: 'username'
              ),
              InputField(
                controller: password,
                labelText: 'Passwort',
                obscureText: true,
                textInputAction: TextInputAction.next,
                  // validatorText: 'password'
              ),
          ElevatedButton(
            onPressed: () async {
              // Zuerst überprüfen Sie den BenutzerNamen
              final isUsernameAvailable = await checkUser();

              if (isUsernameAvailable) {
                // Wenn der BenutzerName verfügbar ist, versuchen Sie, den Benutzer zu registrieren
                await registerUser();
              } else {
                // Zeigen Sie eine Fehlermeldung an oder ergreifen Sie andere Maßnahmen
                print('Der BenutzerName ist bereits vergeben.');
              }
            },
            child: const Text('Anmelden'),
          )
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String password;

  User(this.username, this.password);

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
