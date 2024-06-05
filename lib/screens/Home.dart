import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00C0FF),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Welcome to YourHealth',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00C0FF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Manage your health appointments effortlessly.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            _buildCarouselSlider(),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final isAuthenticated = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  if (isAuthenticated != null && isAuthenticated) {
                    Navigator.pushNamed(context, '/specializations');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00C0FF),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Bắt đầu đặt lịch',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00C0FF),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildAppointmentCard(
                    'Dr. John Doe',
                    'Cardiology',
                    '12th June, 10:00 AM',
                    'assets/images/search_doc_1.png',
                  ),
                  _buildAppointmentCard(
                    'Dr. Jane Smith',
                    'Dermatology',
                    '15th June, 11:00 AM',
                    'assets/images/search_doc_2.png',
                  ),
                  _buildAppointmentCard(
                    'Dr. Mike Brown',
                    'Neurology',
                    '20th June, 9:00 AM',
                    'assets/images/search_doc_3.png',
                  ),
                  _buildAppointmentCard(
                    'Dr. Emily Davis',
                    'Pediatrics',
                    '22nd June, 3:00 PM',
                    'assets/images/search_doc_4.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Health Tips',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00C0FF),
              ),
            ),
            SizedBox(height: 10),
            _buildHealthTipCard('Eat a Balanced Diet', 'Make sure to eat a variety of foods...'),
            _buildHealthTipCard('Stay Hydrated', 'Drink at least 8 glasses of water a day...'),
            _buildHealthTipCard('Exercise Regularly', 'Engage in physical activities for at least 30 minutes a day...'),
            SizedBox(height: 30),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00C0FF),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: EdgeInsets.only(bottom: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfoItem('Our Address', '123 Health Street, Wellness City, HC 56789'),
                    SizedBox(height: 15),
                    _buildContactInfoItem('Phone Number', '+1 234 567 890'),
                    SizedBox(height: 15),
                    _buildContactInfoItem('Email', 'support@yourhealth.com'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoItem(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00C0FF),
          ),
        ),
        SizedBox(height: 5),
        Text(
          info,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }


  Widget _buildCarouselSlider() {
    final List<String> imgList = [
      'assets/images/GettyImages-1370613047-600x400.jpg',
      'assets/images/health-aid-covid-teaser.jpg',
      'assets/images/pr-health-care-leadership-600x400.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) => Container(
        child: Center(
          child: Image.asset(item, fit: BoxFit.cover, width: 1000),
        ),
      )).toList(),
    );
  }

  Widget _buildAppointmentCard(String doctor, String specialization, String time, String avatar) {
    return Card(
      margin: EdgeInsets.only(right: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(avatar),
              radius: 30,
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00C0FF),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  specialization,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthTipCard(String title, String description) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Color(0xFF00C0FF), size: 30),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00C0FF),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
