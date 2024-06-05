import 'package:doctor_app/screens/Doctor.dart';
import 'package:doctor_app/screens/specializations.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/screens/home.dart'; // Import HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(), // Set HomeScreen as the default screen
      routes: {
        '/specializations': (context) => SpecializationsScreen(),
        '/doctors': (context) => DoctorsScreen(),
      },
    );
  }
}
