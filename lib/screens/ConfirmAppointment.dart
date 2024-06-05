import 'package:doctor_app/models/AppointmentVM.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/models/PatientRecordVM.dart';
import 'package:doctor_app/api/api_service.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  final DoctorBasicVM doctor;
  final String selectedDate;
  final String selectedTime;
  final PatientRecordVM patientRecord;

  const ConfirmAppointmentScreen({
    Key? key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
    required this.patientRecord,
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
              'Date: $selectedDate',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Time: $selectedTime',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Patient Name: ${patientRecord.firstName} ${patientRecord.lastName}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  final appointment = AppointmentVM(
                    patientRecordId: patientRecord.id,
                    doctorId: doctor.id,
                    date: selectedDate,
                    time: selectedTime,
                  );

                  await ApiService().createAppointment(appointment);

                  // Sau khi đặt lịch thành công, quay về trang Home và hiển thị thông báo thành công
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Appointment Confirmed'),
                        content: Text('Your appointment has been confirmed successfully!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Đóng hộp thoại
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to confirm appointment: $e')),
                  );
                }
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
