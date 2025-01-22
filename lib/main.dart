import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'models/notes_database.dart';

void main() async {
  //initilize the note in isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NotesDatabase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesPage(),
    );
  }
}
