import 'package:doctor_app/models/AppointmentVM.dart';
import 'package:doctor_app/models/AuthenticationVM.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/models/DoctorVM.dart';
import 'package:doctor_app/models/LoginVM.dart';
import 'package:doctor_app/models/SpecializationVM.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://2d51-118-70-125-13.ngrok-free.app/api';

  Future<AuthenticationVM> login(LoginVM loginVM) async {
    final url = Uri.parse('$baseUrl/User/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginVM.toJson()),
    );

    if (response.statusCode >= 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return AuthenticationVM.fromJson(responseData);
    } else {
      final Map<String, dynamic> errorData = jsonDecode(response.body);
      return AuthenticationVM(
        isAuthenticated: false,
        message: errorData['message'] ?? 'Failed to login',
      );
    }
  }

  Future<List<SpecializationVM>> fetchSpecializations() async {
    final url = Uri.parse('$baseUrl/Specializations');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SpecializationVM.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load specializations: ${response.reasonPhrase}');
    }
  }

  Future<List<DoctorBasicVM>> getDoctorsBySpecializationId(int specializationId) async {
    final url = Uri.parse('$baseUrl/Doctors/GetDoctorsBySpecizalizationId/$specializationId'); // URL chính xác
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DoctorBasicVM.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors: ${response.reasonPhrase}');
    }
  }

  Future<List<DoctorVM>> fetchDoctors() async {
    final url = Uri.parse('$baseUrl/api/Doctors');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DoctorVM.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors: ${response.reasonPhrase}');
    }
  }

  Future<void> createAppointment(AppointmentVM appointmentVM) async {
    final url = Uri.parse('$baseUrl/api/Appointments');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appointmentVM.toJson()),
    );

    if (response.statusCode == 201) {
      // Handle successful response
    } else {
      throw Exception('Failed to create appointment: ${response.reasonPhrase}');
    }
  }
}