import 'package:flutter/material.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  final DoctorBasicVM doctor;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  const ConfirmAppointmentScreen({
    Key? key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Appointment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have selected the following appointment details:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Doctor: ${doctor.fullName}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Specialization: ${doctor.specializationName}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Date: ${selectedDate.toString().substring(0, 10)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi người dùng xác nhận cuộc hẹn
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
