class DoctorVM {
  final int id;
  final String name;
  final String specialization;

  DoctorVM({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory DoctorVM.fromJson(Map<String, dynamic> json) {
    return DoctorVM(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
    );
  }
}