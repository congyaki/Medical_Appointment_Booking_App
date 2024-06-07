import 'package:doctor_app/models/RegisterVM.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doctor_app/models/AuthenticationVM.dart';
import 'package:doctor_app/models/LoginVM.dart';
import 'package:doctor_app/models/SpecializationVM.dart';
import 'package:doctor_app/models/DoctorBasicVM.dart';
import 'package:doctor_app/models/DoctorVM.dart';
import 'package:doctor_app/models/AppointmentVM.dart';
import 'package:doctor_app/models/PatientRecordVM.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://dc8f-183-80-251-51.ngrok-free.app/api';

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<String> register(RegisterVM registerData) async {
    final url = Uri.parse('$baseUrl/user/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registerData.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode >= 200) {
        return response.body;
      } else {
        throw Exception('Failed to register user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }


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
    final url = Uri.parse('$baseUrl/Doctors/GetDoctorsBySpecizalizationId/$specializationId');
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
    final url = Uri.parse('$baseUrl/Appointment');
    final token = await _getToken(); // Lấy token từ SharedPreferences

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Gửi token trong header
        },
        body: jsonEncode(appointmentVM.toJson()),
      );

      if (response.statusCode >=200) {
        // Xử lý phản hồi thành công, ví dụ như thông báo hoặc cập nhật giao diện người dùng
        print('Appointment created successfully!');
      } else {
        // Xử lý phản hồi lỗi từ server
        throw Exception('Failed to create appointment: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Xử lý lỗi nếu có lỗi xảy ra trong quá trình gửi yêu cầu
      throw Exception('Failed to create appointment: $e');
    }
  }


  Future<List<PatientRecordVM>> getPatientRecords() async {
    final token = await _getToken();
    if (token != null) {
      final url = Uri.parse('$baseUrl/PatientRecords');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => PatientRecordVM.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load patient records: ${response.reasonPhrase}');
      }
    } else {
      throw Exception('Token not found');
    }
  }
}
