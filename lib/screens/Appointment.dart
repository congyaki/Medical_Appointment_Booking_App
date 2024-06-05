// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:doctor_app/api/api_service.dart';
// import 'package:doctor_app/models/DoctorVM.dart';
// import 'package:doctor_app/models/AppointmentVM.dart';
//
// class CreateAppointmentScreen extends StatefulWidget {
//   final DoctorVM doctor;
//
//   CreateAppointmentScreen({required this.doctor});
//
//   @override
//   _CreateAppointmentScreenState createState() => _CreateAppointmentScreenState();
// }
//
// class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
//   final _formKey = GlobalKey<FormState>();
//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   final ApiService _apiService = ApiService();
//   int _patientRecordId = 1; // Giả sử bạn đã có PatientRecordId
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Create Appointment')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
//                 trailing: Icon(Icons.calendar_today),
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: _selectedDate,
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101),
//                   );
//                   if (pickedDate != null && pickedDate != _selectedDate)
//                     setState(() {
//                       _selectedDate = pickedDate;
//                     });
//                 },
//               ),
//               ListTile(
//                 title: Text('Time: ${_selectedTime.format(context)}'),
//                 trailing: Icon(Icons.access_time),
//                 onTap: () async {
//                   TimeOfDay? pickedTime = await showTimePicker(
//                     context: context,
//                     initialTime: _selectedTime,
//                   );
//                   if (pickedTime != null && pickedTime != _selectedTime)
//                     setState(() {
//                       _selectedTime = pickedTime;
//                     });
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     try {
//                       await _apiService.createAppointment(
//                         AppointmentVM(
//                           patientRecordId: _patientRecordId,
//                           doctorId: widget.doctor.id,
//                           date: _selectedDate,
//                           time: _selectedTime,
//                         ),
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment created successfully')));
//                       Navigator.pop(context);
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create appointment')));
//                     }
//                   }
//                 },
//                 child: Text('Create Appointment'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }