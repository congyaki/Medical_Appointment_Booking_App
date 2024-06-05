import 'package:flutter/material.dart';
import 'package:doctor_app/screens/login.dart';
import 'package:doctor_app/screens/specializations.dart';
import 'package:doctor_app/screens/home.dart';
import 'package:doctor_app/screens/Doctor.dart'; // Giả định rằng bạn có màn hình Doctors
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
      home: HomeScreen(),
      routes: {
        '/specializations': (context) => SpecializationsScreen(),
        '/doctors': (context) => DoctorsScreen(), // Định nghĩa route cho DoctorsScreen
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        }
      },
    );
  }

  Future<bool> _checkAuthentication() async {
    final token = await _storage.read(key: 'token');
    return token != null;
  }
}
