import 'package:flutter/material.dart';

class SwimCourseScreen extends StatefulWidget {
  const SwimCourseScreen({Key? key}) : super(key: key);

  @override
  State<SwimCourseScreen> createState() => _SwimCourseScreenState();
}

class _SwimCourseScreenState extends State<SwimCourseScreen> {
  final List<SwimCourse> _swimCourse = [
    SwimCourse('Anfängerkurs', '100€', 'Dies ist ein Kurs für Anfänger.'),
    SwimCourse('Fortgeschrittenenkurs', '150€', 'Dies ist ein fortgeschrittener Kurs.'),
    // Weitere Kurse hier hinzufügen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schwimmkurse',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _swimCourse.length,
        itemBuilder: (context, index) {
          final course = _swimCourse[index];
          return Dismissible(
            key: Key(course.name),
            background: Container(
              color: Colors.red, // Hintergrundfarbe beim Löschen
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              color: Colors.orange, // Hintergrundfarbe beim Bearbeiten
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // Hier können Sie den Löschvorgang implementieren.
                _swimCourse.removeAt(index);
                return true; // Zurückgeben true, um den Kurs zu löschen.
              } else if (direction == DismissDirection.startToEnd) {
                // Hier können Sie den Bearbeitungsvorgang implementieren.
                // Zum Beispiel: Navigator.push(...) für eine Bearbeitungsseite.
                return false; // Zurückgeben false, um den Kurs nicht zu löschen.
              }
              return false; // Standardmäßig keinen Vorgang durchführen.
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0,
                child: ExpansionTile(
                  title: Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    course.price,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Hier können Sie Code hinzufügen, um einen neuen Kurs hinzuzufügen.
          // Zum Beispiel: Navigator.push(...) für eine neue Eingabeseite.
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SwimCourse {
  final String name;
  final String price;
  final String description;

  SwimCourse(this.name, this.price, this.description);
}
