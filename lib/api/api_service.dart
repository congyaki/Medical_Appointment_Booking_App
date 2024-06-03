import 'package:doctor_app/models/AppointmentVM.dart';
import 'package:doctor_app/models/LoginVM.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/DoctorVM.dart';
import '../models/SpecializationVM.dart';

class ApiService {
  static const String baseUrl = 'https://localhost:7259/api';


  Future<void> login(LoginVM loginVM) async {
    final url = Uri.parse('$baseUrl/User/token');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginVM.toJson()),
    );

    if (response.statusCode == 200) {
      // Xử lý phản hồi thành công
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<SpecializationVM>> fetchSpecializations() async {
    final url = Uri.parse('$baseUrl/Specializations');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SpecializationVM.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load specializations');
    }
  }

  Future<List<DoctorVM>> fetchDoctors() async {
    final url = Uri.parse('$baseUrl/Doctors');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DoctorVM.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<void> createAppointment(AppointmentVM appointmentVM) async {
    final url = Uri.parse('$baseUrl/Appointment');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appointmentVM.toJson()),
    );

    if (response.statusCode == 201) {
      // Xử lý phản hồi thành công
    } else {
      throw Exception('Failed to create appointment');
    }
  }
}