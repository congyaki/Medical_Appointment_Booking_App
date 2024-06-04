import 'package:doctor_app/screens/Login.dart';
import 'package:flutter/material.dart';

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
                // Xử lý sự kiện khi nhấn nút "Bắt đầu đặt lịch"
                // Kiểm tra đăng nhập và chuyển hướng tới trang đăng nhập nếu cần
                final isAuthenticated = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                if (isAuthenticated != null && isAuthenticated) {
                  // Người dùng đã đăng nhập, chuyển hướng đến trang chọn specialization
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
