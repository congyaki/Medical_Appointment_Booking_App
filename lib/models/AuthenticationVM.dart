class AuthenticationVM {
  final bool isAuthenticated;
  final String? token;
  final String? email;
  final String? userName;
  final List<String>? roles;
  final String? message;

  AuthenticationVM({
    required this.isAuthenticated,
    this.token,
    this.email,
    this.userName,
    this.roles,
    this.message,
  });

  factory AuthenticationVM.fromJson(Map<String, dynamic> json) {
    return AuthenticationVM(
      isAuthenticated: json['isAuthenticated'],
      token: json['token'],
      email: json['email'],
      userName: json['userName'],
      roles: List<String>.from(json['roles'] ?? []),
      message: json['message'],
    );
  }
}
