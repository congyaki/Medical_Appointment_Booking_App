import 'package:doctor_app/models/SpecializationVM.dart';

class DoctorVM {
  final int id;
  final String userId;
  final int experience;
  final String title;
  final String avatar;
  final String phoneNumber;
  final String address;
  final DateTime dateOfBirth;
  final List<SpecializationVM> specializations;

  DoctorVM({
    required this.id,
    required this.userId,
    required this.experience,
    required this.title,
    required this.avatar,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.specializations,
  });

  factory DoctorVM.fromJson(Map<String, dynamic> json) {
    var specializationsFromJson = json['specializations'] as List;
    List<SpecializationVM> specializationList = specializationsFromJson
        .map((specialization) => SpecializationVM.fromJson(specialization))
        .toList();

    return DoctorVM(
      id: json['id'],
      userId: json['userId'],
      experience: json['experience'],
      title: json['title'],
      avatar: json['avatar'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      specializations: specializationList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'experience': experience,
      'title': title,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'specializations': specializations.map((e) => e.toJson()).toList(),
    };
  }
}