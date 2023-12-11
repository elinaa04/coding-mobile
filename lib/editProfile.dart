import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profil.dart';

class EditProfil extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  // Use TextEditingController for each input field
  final TextEditingController nisnController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  // Function to send a request to update the profile
  Future<bool> editProfile(String nisn, String namaLengkap, String tanggalLahir,
      String jenisKelamin, String kelas) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3301/editProfile'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'nisn': nisn,
          'namaLengkap': namaLengkap,
          'tanggalLahir': tanggalLahir,
          'jenisKelamin': jenisKelamin,
          'kelas': kelas,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error: $error");
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Load existing user data when the widget is initialized
    fetchDataAndUpdateView();
  }

  // Function to fetch user data and update the view
  Future<void> fetchDataAndUpdateView() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3301/getProfile'));

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);

        // Set the controller values with the fetched data
        nisnController.text = userData['nisn'] ?? '';
        namaLengkapController.text = userData['namaLengkap'] ?? '';
        tanggalLahirController.text = userData['tanggalLahir'] ?? '';
        jenisKelaminController.text = userData['jenisKelamin'] ?? '';
        kelasController.text = userData['kelas'] ?? '';
      } else {
        print(
            "Failed to get profile data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error during data fetch: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Profil",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Center(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/image/gambar.jpeg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 30), //ukuran lebar border
                child: Container(
                  height: 520,
                  //color: Colors.green,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // text ke kiri
                    children: [
                      //Bagian Username
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "NISN",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: nisnController,
                          // Set readOnly to false to enable editing
                          readOnly: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey[300]!,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      //Bagian Nama
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Nama Lengkap",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: namaLengkapController,
                          readOnly: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey[300]!,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      //Bagian TTL
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Tanggal Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: tanggalLahirController,
                          readOnly:
                              false, // Set readOnly to false to enable editing
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey[300]!,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      //Bagian Jenis Kelamin
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: jenisKelaminController,
                          readOnly:
                              false, // Set readOnly to false to enable editing
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey[300]!,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      //Bagian Kelas
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Kelas",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800]!,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      //Bagian border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          controller: kelasController,
                          readOnly:
                              false, // Set readOnly to false to enable editing
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 20, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.grey[300]!,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                      // Bagian Simpan
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            String nisn = nisnController.text;
                            String namaLengkap = namaLengkapController.text;
                            String tanggalLahir = tanggalLahirController.text;
                            String jenisKelamin = jenisKelaminController.text;
                            String kelas = kelasController.text;

                            bool editSuccess = await editProfile(
                              nisn,
                              namaLengkap,
                              tanggalLahir,
                              jenisKelamin,
                              kelas,
                            );

                            if (editSuccess) {
                              // Refresh data after successful edit
                              fetchDataAndUpdateView();
                              // Navigate back to the profile screen
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed to update data"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
