import 'package:flutter/material.dart';
import 'package:doctor_app/screens/login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YourHealth',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Kiểm tra đăng nhập, nếu chưa đăng nhập thì chuyển tới trang đăng nhập
                final isAuthenticated = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                if (isAuthenticated != null && isAuthenticated) {
                  // Nếu đăng nhập thành công, chuyển hướng tới trang chọn chuyên khoa
                  Navigator.pushNamed(context, '/specializations');
                }
              },
              child: Text('Bắt đầu đặt lịch'),
            ),
          ],
        ),
      ),
    );
  }
}
