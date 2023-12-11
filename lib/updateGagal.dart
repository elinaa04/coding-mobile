import 'package:flutter/material.dart';
import 'updatePassword.dart';

class Update_gagal extends StatelessWidget {
  const Update_gagal({super.key});

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
                      "Password Gagal di Perbarui",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 146, 17, 8),
                      ),
                    ),
                    Image.asset(
                      width: 100,
                      height: 150,
                      "assets/image/gagal.png",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePassword(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(33333),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ))),
                      child: Text("coba lagi"),
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
