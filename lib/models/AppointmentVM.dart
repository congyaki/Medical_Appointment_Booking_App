class AppointmentVM {
  final int patientRecordId;
  final int doctorId;
  final String date; // Thay đổi kiểu dữ liệu từ DateTime thành String
  final String time; // Thay đổi kiểu dữ liệu từ TimeOfDay thành String

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
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientRecordId': patientRecordId,
      'doctorId': doctorId,
      'date': date, // Không cần chuyển đổi định dạng
      'time': time, // Không cần chuyển đổi định dạng
    };
  }
}
