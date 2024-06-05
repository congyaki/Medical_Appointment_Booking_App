class DoctorBasicVM {
  final int id;
  final int experience;
  final String avatar;
  final String fullName;

  DoctorBasicVM({
    required this.id,
    required this.experience,
    required this.avatar,
    required this.fullName,
  });

  factory DoctorBasicVM.fromJson(Map<String, dynamic> json) {
    return DoctorBasicVM(
      id: json['id'],
      experience: json['experience'],
      avatar: json['avatar'],
      fullName: json['fullName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'experience': experience,
      'avatar': avatar,
      'fullName': fullName,
    };
  }
}