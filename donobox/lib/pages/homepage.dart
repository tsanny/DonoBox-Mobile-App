import 'package:donobox/model/mynotification.dart';
import 'package:donobox/pages/AboutUsPage.dart';
import 'package:donobox/pages/FAQPage.dart';
import 'package:donobox/pages/mynotification_page.dart';
import 'package:flutter/material.dart';
import '../drawer/sidebar.dart';
import 'AskUsPage.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:donobox/pages/artikel_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();

    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: BottomMenu(),
        appBar: AppBar(
          backgroundColor: Color(0xFF3F4E4F),
          title: Text(request.jsonData['username'] == null
              ? ""
              : "Hi, ${request.jsonData['username']}!"),
          actions: <Widget>[
            request.loggedIn
            ?IconButton(
              icon: const Icon(
                Icons.notifications_active,
                color: Color(0xFF879999),
                size: 30,
              ),
              tooltip: 'Notification',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyNotificationPage()),
                );
              },
            )
            :Container(),
          ],
        ),
        drawer: const drawer(),
        body: SafeArea(
            child: Container(
                margin: const EdgeInsets.only(top: 0, left: 24, right: 24),
                child: Column(children: [
                  Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                        const SizedBox(height: 32),
                        Center(
                          child: Image.asset(
                            'assets/donobox.png',
                            scale: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: Text(
                            'Donobox',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF879999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 64),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Route menu ke halaman form
                                Navigator.pushReplacement(
                                  context,

                                  MaterialPageRoute(
                                      builder: (context) => const AboutUs()),
                                );
                              },
                              child: Card(
                                  color: Color(0xFFF7F6F2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Column(
                                        children: [

                                          Image.asset(
                                            'assets/logo.png',
                                            width: 105,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "About Us",

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ),

                                  )),

                            ),
                            GestureDetector(
                              // sambungin ke page modul masing2
                              // onTap: () {
                              //   // Route menu ke halaman form
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => const MyHomePage()),
                              //   );
                              // },

                              child: Card(

                                  color: Color(0xFFF7F6F2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Column(
                                        children: [

                                          Image.asset(
                                            'assets/article.png',
                                            width: 80,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Article",

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ),

                                  )),
                              onTap: () {
                                //   // Route menu ke halaman form
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ArtikelPage()),
                                );
                              },

                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            GestureDetector(
                              // sambungin ke page modul masing2
                              // onTap: () {
                              //   // Route menu ke halaman form
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => const MyHomePage()),
                              //   );
                              // },

                              child: Card(

                                  color: Color(0xFFF7F6F2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Column(
                                        children: [

                                          Image.asset(
                                            'assets/cek_saldo.png',
                                            width: 90,
                                          ),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Cek Saldo",

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),

                                          )
                                        ],
                                      ),
                                    ),

                                  )),

                            ),
                            GestureDetector(
                              // sambungin ke page modul masing2
                              // onTap: () {
                              //   // Route menu ke halaman form
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => const MyHomePage()),
                              //   );
                              // },

                              child: Card(

                                  color: Color(0xFFF7F6F2),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      child: Column(
                                        children: [

                                          Image.asset(
                                            'assets/crowdfund.png',
                                            width: 90,
                                          ),

                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "CrowdFund",

                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),

                                          )
                                        ],
                                      ),
                                    ),

                                  )),

                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Butuh Bantuan?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF879999),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Route menu ke halaman form
                                Navigator.pushReplacement(
                                  context,

                                  MaterialPageRoute(
                                      builder: (context) => const FAQ()),
                                );
                              },
                              child: _roundedButton(title: 'FAQ'),

                            ),
                            GestureDetector(
                              onTap: () {
                                // Route menu ke halaman form
                                Navigator.pushReplacement(
                                  context,

                                  MaterialPageRoute(
                                      builder: (context) => const AskUsPage()),
                                );
                              },
                              child: _roundedButton(title: 'Ask Us'),

                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                      ]
                    )
                  )
            ])
          ))
      );

  }

  Widget _roundedButton({
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 60,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF7F5F2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
