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
      appBar: AppBar(title: Text('Specializations')),
      body: FutureBuilder<List<SpecializationVM>>(
        future: _specializations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load specializations: ${snapshot.error}'));
          } else {
            final specializations = snapshot.data!;
            return ListView.builder(
              itemCount: specializations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(specializations[index].name),
                  subtitle: Text(specializations[index].description),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/doctors',
                      arguments: specializations[index],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
