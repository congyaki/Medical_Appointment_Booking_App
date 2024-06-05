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
      appBar: AppBar(
        title: Text('Patient Records',
          style: TextStyle(
            color: Colors.white, // Màu chữ là trắng
            fontWeight: FontWeight.bold, // Chữ in đậm
          ),
        ),
        backgroundColor: Color(0xFF00C0FF),
      ),
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
              padding: EdgeInsets.all(10.0),
              itemCount: patientRecords.length,
              itemBuilder: (context, index) {
                final patientRecord = patientRecords[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      '${patientRecord.firstName} ${patientRecord.lastName}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date of Birth: ${patientRecord.dateOfBirth}'),
                          Text('Gender: ${patientRecord.gender}'),
                          Text('Address: ${patientRecord.address}'),
                          Text('Phone Number: ${patientRecord.phoneNumber}'),
                          Text('Email: ${patientRecord.email}'),
                        ],
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Color(0xFF00C0FF)),
                    onTap: () {
                      _confirmAppointment(patientRecord);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
