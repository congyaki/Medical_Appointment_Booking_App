import 'package:flutter/material.dart';
import 'package:doctor_app/api/api_service.dart';
import 'package:doctor_app/models/LoginVM.dart';
import 'package:doctor_app/models/AuthenticationVM.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _saveToken(String? token) async {
    if (token != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        final authResult = await _apiService.login(LoginVM(email: _email, password: _password));
        setState(() {
          _isLoading = false;
        });

        if (authResult.isAuthenticated) {
          await _saveToken(authResult.token); // Lưu token vào thiết bị
          await _saveLoginStatus(true); // Lưu trạng thái đăng nhập
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful!')),
          );
          Navigator.pop(context, true); // Trả về true khi đăng nhập thành công
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(authResult.message ?? 'Failed to login')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[300]!],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Icon(Icons.person, size: 60, color: Colors.blue[900]),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.email, color: Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                        obscureText: true,
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
