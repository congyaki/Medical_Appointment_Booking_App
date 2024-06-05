import 'package:flutter/material.dart';
import 'package:doctor_app/api/api_service.dart';
import 'package:doctor_app/models/SpecializationVM.dart';

class SpecializationsScreen extends StatefulWidget {
  @override
  _SpecializationsScreenState createState() => _SpecializationsScreenState();
}

class _SpecializationsScreenState extends State<SpecializationsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<SpecializationVM>> _specializations;

  @override
  void initState() {
    super.initState();
    _specializations = _apiService.fetchSpecializations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Specializations',
          style: TextStyle(
            color: Colors.white, // Màu chữ là trắng
            fontWeight: FontWeight.bold, // Chữ in đậm
          ),
        ),
        backgroundColor: Color(0xFF00C0FF), // Màu nền là xanh
      ),
      body: FutureBuilder<List<SpecializationVM>>(
        future: _specializations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load specializations: ${snapshot.error}'));
          } else {
            final specializations = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Choose Specialization',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: specializations.length,
                    itemBuilder: (context, index) {
                      return _buildSpecializationCard(specializations[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildSpecializationCard(SpecializationVM specialization) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/doctors',
              arguments: specialization,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(
                  Icons.local_hospital, // Thay thế bằng biểu tượng phù hợp hoặc biểu tượng FontAwesome
                  size: 40,
                  color: Colors.blue,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      specialization.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      specialization.description,
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
        ),
      ),
    );
  }
}
