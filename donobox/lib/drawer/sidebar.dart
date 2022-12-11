import 'package:donobox/pages/AboutUsPage.dart';
import 'package:donobox/pages/AskUsPage.dart';
import 'package:flutter/material.dart';
import 'package:donobox/artikel_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:donobox/login.dart';

import '../pages/homepage.dart';

import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context, request),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Material(
        color: Color(0xFF3F4E4F),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AskUsPage()),
            );
          },
          child: Container(
            color: Color(0xFF3F4E4F),
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                SizedBox(height: 12),
                Text(
                  'Nama',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context, CookieRequest request) =>
      Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFFA2CC83)),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/logo.png',
                width: 35,
              ),
              title: const Text('About Us'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.article, color: Color(0xFFA2CC83)),
              title: const Text('Article'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ArtikelPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallet, color: Color(0xFFA2CC83)),
              title: const Text('Cek Saldo'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.money_rounded, color: Color(0xFFA2CC83)),
              title: const Text('CrowdFund'),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            !request.loggedIn
                ? ListTile(
                    title: const Text('Login'),
                    onTap: () {
                      // Route menu ke halaman form
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  )
                : ListTile(
                    title: const Text("Logout"),
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      final response = await request.logout(
                          "https://pbp-c04.up.railway.app/autentikasi/logout_apk/");
                    },
                  )
          ],
        ),
      );
}
