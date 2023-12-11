import 'package:flutter/material.dart';
import 'profil.dart';

class Update_berhasil extends StatelessWidget {
  const Update_berhasil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "Password Berhasil di Perbarui",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                    Image.asset(
                      "assets/image/ceklist.png",
                      width: 100,
                      height: 150,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Profil(nisn: 'someNISNValue'),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0x33333),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      child: Text("selesai"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
