import 'package:flutter/material.dart';
import 'package:doctor_app/api/api_service.dart';
import 'package:doctor_app/models/LoginVM.dart';
import 'package:doctor_app/models/AuthenticationVM.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = 'duccong29092003@gmail.com'; // Giá trị mặc định cho email
  String _password = '';
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController(text: 'duccong29092003@gmail.com');

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful!')),
          );
          Navigator.pop(context, true); // Trả về true khi đăng nhập thành công
        } else {
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
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController, // Thiết lập giá trị mặc định cho email
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                obscureText: true,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
