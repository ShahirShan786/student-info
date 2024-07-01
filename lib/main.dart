import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_info/function/functions.dart';

import 'package:student_info/screens/studentListScreen.dart';

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student info App",
      home: StudentListscreen(),
    );
  }
}