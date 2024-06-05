import 'package:doctor_app/screens/ConfirmAppointment.dart';
import 'package:flutter/material.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';

class AppointmentDateTimePicker extends StatefulWidget {
  final DoctorBasicVM doctor;

  const AppointmentDateTimePicker({Key? key, required this.doctor}) : super(key: key);

  @override
  _AppointmentDateTimePickerState createState() => _AppointmentDateTimePickerState();
}

class _AppointmentDateTimePickerState extends State<AppointmentDateTimePicker> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)), // Chỉ cho phép chọn ngày trong vòng 30 ngày kể từ ngày hiện tại
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Appointment Date and Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            Text('Selected Date: ${_selectedDate.toString().substring(0, 10)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 20),
            Text('Selected Time: ${_selectedTime.format(context)}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi người dùng xác nhận ngày và giờ
                // Ví dụ: gọi hàm để tạo cuộc hẹn với ngày và giờ đã chọn
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmAppointmentScreen(
                      doctor: widget.doctor,
                      selectedDate: _selectedDate,
                      selectedTime: _selectedTime,
                    ),
                  ),
                );
              },
              child: Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
