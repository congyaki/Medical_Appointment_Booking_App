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
        title: Text(
          'Select Appointment Date and Time',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF00C0FF),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDateTimeButton(
                        onPressed: () => _selectDate(context),
                        icon: Icons.calendar_today,
                        label: 'Select Date',
                      ),
                      SizedBox(height: 20),
                      _buildSelectedDateTimeText(
                        text: 'Selected Date: ${_selectedDate.toString().substring(0, 10)}',
                      ),
                      SizedBox(height: 20),
                      _buildDateTimeButton(
                        onPressed: () => _selectTime(context),
                        icon: Icons.access_time,
                        label: 'Select Time',
                      ),
                      SizedBox(height: 20),
                      _buildSelectedDateTimeText(
                        text: 'Selected Time: ${_selectedTime.format(context)}',
                      ),
                      SizedBox(height: 20),
                      _buildConfirmAppointmentButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF00C0FF),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Widget _buildSelectedDateTimeText({required String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _buildConfirmAppointmentButton() {
    return ElevatedButton.icon(
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
      icon: Icon(Icons.check),
      label: Text(
        'Confirm Appointment',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF00C0FF),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
