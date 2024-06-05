class PatientRecordVM {
  final int customerId;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String gender;
  final String address;
  final String phoneNumber;
  final String email;

  PatientRecordVM({
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
  });

  factory PatientRecordVM.fromJson(Map<String, dynamic> json) {
    return PatientRecordVM(
      customerId: json['customerId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
    );
  }
}
