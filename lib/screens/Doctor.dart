import 'package:doctor_app/screens/AppointmentDateTimePicker.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/api/api_service.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/models/SpecializationVM.dart';
class DoctorsScreen extends StatelessWidget {
  void _showConfirmationDialog(BuildContext context, DoctorBasicVM doctor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Selection'),
          content: Text('Are you sure you want to choose Dr. ${doctor.fullName}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Đóng hộp thoại và trả về giá trị false
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Đóng hộp thoại và trả về giá trị true
                // Chuyển hướng sang trang chọn ngày và giờ với thông tin bác sĩ
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentDateTimePicker(doctor: doctor),
                  ),
                );
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SpecializationVM specialization = ModalRoute.of(context)!.settings.arguments as SpecializationVM;

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors in ${specialization.name}'),
      ),
      body: FutureBuilder<List<DoctorBasicVM>>(
        future: ApiService().getDoctorsBySpecializationId(specialization.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load doctors: ${snapshot.error}'));
          } else {
            final doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doctors[index].avatar),
                  ),
                  title: Text(doctors[index].fullName),
                  subtitle: Text('Experience: ${doctors[index].experience} years'),
                  onTap: () {
                    // Hiển thị hộp thoại xác nhận khi người dùng chọn một bác sĩ
                    _showConfirmationDialog(context, doctors[index]);
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

