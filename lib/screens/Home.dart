import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HealthMed',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF00C0FF),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        // Remove the actions from the app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF00C0FF),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Navigate to the profile page
                Navigator.pop(context); // Close the drawer
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Text('Appointment'),
              onTap: () {
                // Navigate to the appointment page
                Navigator.pop(context); // Close the drawer
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
                if (isLoggedIn) {
                  // Log out logic
                  prefs.setBool('isLoggedIn', false); // Set isLoggedIn to false
                  // Navigate to the home page or any other appropriate page after logout
                  Navigator.pop(context); // Close the drawer
                  // Add navigation logic here
                } else {
                  // Navigate to the login page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Welcome to HealthMed',
              style: TextStyle(
                fontSize: 26,
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
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
                  if (isLoggedIn) {
                    Navigator.pushNamed(context, '/specializations');
                  } else {
                    final isAuthenticated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                    if (isAuthenticated != null && isAuthenticated) {
                      Navigator.pushNamed(context, '/specializations');
                    }
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
              'Blog',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00C0FF),
              ),
            ),
            SizedBox(height: 10),
            _buildBlogPost(
              '10 Tips for a Healthy Lifestyle',
              'Follow these simple tips to maintain a healthy lifestyle...',
              'assets/images/blog1.jpg',
            ),
            _buildBlogPost(
              'Understanding Mental Health',
              'Learn about the importance of mental health and how to take care of it...',
              'assets/images/blog2.png',
            ),
            _buildBlogPost(
              'The Benefits of Regular Exercise',
              'Discover the numerous benefits of incorporating regular exercise into your daily routine...',
              'assets/images/blog3.png',
            ),

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

  Widget _buildContactUsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _buildContactInfoItem('Address', '123 Health Street, City, Country'),
        _buildContactInfoItem('Phone', '+123 456 7890'),
        _buildContactInfoItem('Email', 'info@healthmed.com'),
      ],
    );
  }

  Widget _buildBlogPost(String title, String description, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Add navigation logic to the full blog post page
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
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
      ),
    );
  }
}
