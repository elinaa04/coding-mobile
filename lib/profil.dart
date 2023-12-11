import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'editProfile.dart';
import 'updatePassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  final String nisn;

  Profil({Key? key, required this.nisn}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(
        Uri.parse('http://localhost:3301/profilesiswa'),
        body: {'nisn': widget.nisn},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> profileData = json.decode(response.body);

        setState(() {
          namaLengkapController.text = profileData['namaLengkap'] ?? '';
          tanggalLahirController.text = profileData['tanggalLahir'] ?? '';
          jenisKelaminController.text = profileData['jenisKelamin'] ?? '';
          kelasController.text = profileData['kelas'] ?? '';
        });
      } else {
        print("Gagal mengambil data profil: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
      print("Error Details: ${error.toString()}");
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
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfil()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Center(
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian NISN
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
// Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(text: widget.nisn),
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

// Bagian Nama Lengkap
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
// Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          readOnly: true,
                          controller: namaLengkapController,
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

// Bagian Tanggal Lahir
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
// Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          readOnly: true,
                          controller: tanggalLahirController,
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

// Bagian Jenis Kelamin
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
// Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          readOnly: true,
                          controller: jenisKelaminController,
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

// Bagian Kelas
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
// Bagian Border
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          readOnly: true,
                          controller: kelasController,
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
                      // Bagian Ganti Password
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdatePassword(),
                              ),
                            );
                          },
                          child: const Text("Ganti Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: 1,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    // Implement your logic here
  }
}
