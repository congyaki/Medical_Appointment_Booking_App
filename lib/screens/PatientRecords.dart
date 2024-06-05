import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/screens/ConfirmAppointment.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/api/api_service.dart';
import 'package:doctor_app/models/PatientRecordVM.dart';

class PatientRecordScreen extends StatefulWidget {
  final DoctorBasicVM doctor;
  final String selectedDate;
  final String selectedTime;

  PatientRecordScreen({
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  _PatientRecordScreenState createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<PatientRecordVM>> _patientRecords;

  @override
  void initState() {
    super.initState();
    _fetchPatientRecords();
  }

  Future<void> _fetchPatientRecords() async {
    setState(() {
      _patientRecords = _apiService.getPatientRecords();
    });
  }

  void _confirmAppointment(PatientRecordVM patientRecord) {
    // Chuyển hướng sang trang ConfirmAppointment và truyền dữ liệu cần thiết
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmAppointmentScreen(
          doctor: widget.doctor,
          selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime,
          patientRecord: patientRecord,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Records')),
      body: FutureBuilder<List<PatientRecordVM>>(
        future: _patientRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load patient records: ${snapshot.error}'));
          } else {
            final patientRecords = snapshot.data!;
            return ListView.builder(
              itemCount: patientRecords.length,
              itemBuilder: (context, index) {
                final patientRecord = patientRecords[index];
                return ListTile(
                  title: Text('Name: ${patientRecord.firstName} ${patientRecord.lastName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date of Birth: ${patientRecord.dateOfBirth}'),
                      Text('Gender: ${patientRecord.gender}'),
                      Text('Address: ${patientRecord.address}'),
                      Text('Phone Number: ${patientRecord.phoneNumber}'),
                      Text('Email: ${patientRecord.email}'),
                    ],
                  ),
                  onTap: () {
                    // Khi người dùng chọn một hồ sơ bệnh nhân, gọi hàm _confirmAppointment
                    _confirmAppointment(patientRecord);
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

