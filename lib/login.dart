import 'package:flutter/material.dart';
import 'profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final TextEditingController nisnController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({Key? key}) : super(key: key);

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> loginUser(String nisn, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3301/loginsiswa'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nisn': nisn,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('nisn', nisn);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 185,
                    child: Image.asset('assets/image/login.png'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("NISN", nisnController),
                  _buildTextField("Password", passwordController,
                      isPassword: true),
                  _buildRememberMeCheckbox(),
                  _buildLoginButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              decorationColor: Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 5),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  width: 2.0,
                  color: (Colors.grey[300])!,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: (Colors.grey[300])!,
                ),
              ),
              suffixIcon: isPassword
                  ? Icon(Icons.remove_red_eye, color: (Colors.grey[300])!)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Checkbox(value: false, onChanged: (value) {}),
          const Text("Remember me"),
          const SizedBox(width: 13, height: 13),
          const Expanded(
            child: Align(
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: ElevatedButton(
          onPressed: () async {
            String nisn = nisnController.text;
            String password = passwordController.text;

            bool loginSuccess = await loginUser(nisn, password);

            if (loginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Profil(nisn: nisn),
                ),
              );
            } else {
              _showErrorDialog(
                context,
                'Login Gagal. NISN atau Password salah',
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF333333),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: const Text("Login"),
        ),
      ),
    );
  }
}
