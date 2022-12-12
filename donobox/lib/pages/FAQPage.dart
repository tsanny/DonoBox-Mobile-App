import 'package:flutter/material.dart';

import '../drawer/sidebar.dart';

class FAQ extends StatelessWidget {
  const FAQ({
    Key? key,
    required this.loggedUsername,
    required this.loggedRole,
  }) : super(key: key);

  final String loggedUsername;
  final String loggedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F4E4F),
      ),
        drawer: drawer(
          loggedUsername: loggedUsername,
          loggedRole: loggedRole,
        ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3F4E4F),
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Column(
                    children: const [
                      SizedBox(height: 80),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "FAQ",
                          style: TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: Color(0xFF3F4E4F),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                              margin: new EdgeInsets.fromLTRB(0, 0, 0, 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title:
                                Center(
                                  child: Column(
                                    children: const [
                                      SizedBox(height: 30),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Apakah donasi saya tersalurkan 100%?",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF879999),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        child: Text(
                                          "Donobox akan mengalokasikan donasi operasional sebesar 5% dari total donasi yang terkumpul. Sebagai perusahaan bermisi sosial, Donobox berupaya untuk bisa mengelola platform secara berkelanjutan.",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Bagaimana saya tahu donasi \nsudah terverifikasi?",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF879999),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        child: Text(
                                          "Setelah donasi terverifikasi, maka Anda akan mendapatkan notifikasi melalui email ataupun SMS jika Anda memasukkan nomor WhatsApp",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Apakah wajib membuat akun \nsebelum berdonasi?",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF879999),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        child: Text(
                                          "Ya, Anda diwajibkan untuk membuat akun sebelum Anda mulai berdonasi.",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}