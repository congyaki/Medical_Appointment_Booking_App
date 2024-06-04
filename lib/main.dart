import 'package:flutter/material.dart';
import 'package:doctor_app/screens/login.dart';
import 'package:doctor_app/screens/specializations.dart';
import 'package:doctor_app/screens/home.dart';
import 'package:doctor_app/screens/doctor.dart'; // Giả định rằng bạn có một màn hình Doctor
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YourHealth',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/specializations': (context) => SpecializationsScreen(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  final _storage = FlutterSecureStorage(); // Thêm dòng này để khởi tạo _storage

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Bổ sung Center để căn giữa
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

  // Hàm kiểm tra xác thực
  Future<bool> _checkAuthentication() async {
    final token = await _storage.read(key: 'token');
    return token != null;
  }
}