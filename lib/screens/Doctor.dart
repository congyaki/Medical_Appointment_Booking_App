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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm Selection',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Are you sure you want to choose Dr. ${doctor.fullName}?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Đóng hộp thoại và trả về giá trị false
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF00C0FF),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final SpecializationVM specialization =
    ModalRoute.of(context)!.settings.arguments as SpecializationVM;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choose Doctor',
          style: TextStyle(
            color: Colors.white, // Màu chữ là trắng
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF00C0FF), // Màu nền là xanh
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      // Hiển thị hộp thoại xác nhận khi người dùng chọn một bác sĩ
                      _showConfirmationDialog(context, doctors[index]);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: InkWell(
                        onTap: () {
                          // Hiển thị hộp thoại xác nhận khi người dùng chọn một bác sĩ
                          _showConfirmationDialog(context, doctors[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(doctors[index].avatar),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctors[index].fullName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Specialization: ${doctors[index].specializationName}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Text(
                                      'Experience: ${doctors[index].experience} years',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
