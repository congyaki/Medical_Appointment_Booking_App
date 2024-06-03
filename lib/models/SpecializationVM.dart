class SpecializationVM {
  final int id;
  final String name;
  final String description;

  SpecializationVM({
    required this.id,
    required this.name,
    required this.description,
  });

  factory SpecializationVM.fromJson(Map<String, dynamic> json) {
    return SpecializationVM(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}