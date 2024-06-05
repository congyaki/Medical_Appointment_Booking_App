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
        title: Text('Confirm Appointment',
          style: TextStyle(
            color: Colors.white, // Màu chữ là trắng
            fontWeight: FontWeight.bold, // Chữ in đậm
          ),
        ),
        backgroundColor: Color(0xFF00C0FF),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 20), // Thêm margin để tạo khoảng cách giữa các phần tử
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thay đổi kiểu chữ và đặt căn giữa cho tiêu đề "Appointment Detail"
                      Center(
                        child: Text(
                          'Appointment Detail',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00C0FF),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Thêm khoảng cách giữa tiêu đề và thông tin cụ thể
                      _buildInfoRow('Doctor:', doctor.fullName),
                      _buildInfoRow('Specialization:', doctor.specializationName),
                      _buildInfoRow('Date:', selectedDate),
                      _buildInfoRow('Time:', selectedTime),
                      _buildInfoRow('Patient Name:', '${patientRecord.firstName} ${patientRecord.lastName}'),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final appointment = AppointmentVM(
                          patientRecordId: patientRecord.id,
                          doctorId: doctor.id,
                          date: selectedDate,
                          time: selectedTime,
                        );

                        await ApiService().createAppointment(appointment);

                        Navigator.of(context).popUntil((route) => route.isFirst);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFF00C0FF), // Màu nền của dialog
                              title: Text(
                                'Appointment Confirmed',
                                style: TextStyle(
                                  color: Colors.white, // Màu chữ của tiêu đề
                                ),
                              ),
                              content: Text(
                                'Your appointment has been confirmed successfully!',
                                style: TextStyle(
                                  color: Colors.white, // Màu chữ của nội dung
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white, // Màu chữ của nút
                                    ),
                                  ),
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
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF00C0FF),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00C0FF),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
