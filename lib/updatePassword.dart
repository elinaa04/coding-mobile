import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'updateBerhasil.dart';
import 'updateGagal.dart';

class UpdatePassword extends StatelessWidget {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  UpdatePassword({Key? key}) : super(key: key);

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse('http://localhost:3301/updatepassword'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red,
                margin: EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      "Update Password",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 185,
                      child: Image.asset('assets/image/update.png'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),

                // color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Password Lama",
                        style: TextStyle(
                          fontSize: 12,
                          decorationColor: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: oldPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 30, right: 5),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: (Colors.grey[300])!,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 3,
                              color: (Colors.grey[300])!,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: (Colors.grey[300])!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "Password Baru",
                        style: TextStyle(
                          fontSize: 12,
                          decorationColor: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 30, right: 5),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: (Colors.grey[300])!,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              width: 3,
                              color: (Colors.grey[300])!,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: (Colors.grey[300])!,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            String oldPassword = oldPasswordController.text;
                            String newPassword = newPasswordController.text;

                            bool updateSuccess =
                                await updatePassword(oldPassword, newPassword);

                            if (updateSuccess) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Update_berhasil()),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Update_gagal()),
                              );
                            }
                            ;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF333333),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: const Text("Update"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
