import 'package:flutter/material.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/screens/PatientRecords.dart';

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
      lastDate: DateTime.now().add(Duration(days: 30)),
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
        backgroundColor: Color(0xFF00C0FF), // Màu chủ đạo của ứng dụng
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.doctor.avatar),
                radius: 50,
              ),
              SizedBox(height: 20),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientRecordScreen(
                        doctor: widget.doctor,
                        selectedDate: '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                        selectedTime: '${_selectedTime.hour}:${_selectedTime.minute}:00',
                      ),
                    ),
                  );
                },
                child: Text(
                  'Confirm Appointment',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00C0FF), // Màu chủ đạo của ứng dụng
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

