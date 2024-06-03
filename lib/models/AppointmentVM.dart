import 'package:flutter/material.dart';

class AppointmentVM {
  final int patientRecordId;
  final int doctorId;
  final DateTime date;
  final TimeOfDay time;

  AppointmentVM({
    required this.patientRecordId,
    required this.doctorId,
    required this.date,
    required this.time,
  });

  factory AppointmentVM.fromJson(Map<String, dynamic> json) {
    return AppointmentVM(
      patientRecordId: json['patientRecordId'],
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].split(':')[0]),
        minute: int.parse(json['time'].split(':')[1]),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientRecordId': patientRecordId,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
    };
  }
}