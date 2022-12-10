import 'main.dart';
import 'login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Counter'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: '',
                        )),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                    final response = await request.logout(
                        "https://pbp-c04.up.railway.app/autentikasi/logout_apk/");
                  },
                )
        ],
      ),
    );
  }
}
