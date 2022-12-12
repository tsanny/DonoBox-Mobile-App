import 'package:flutter/material.dart';
import '../main.dart';
import 'drawer.dart';
import 'register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
    required this.loggedUsername,
    required this.loggedRole,
  });

  String loggedUsername;
  String loggedRole;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(""),
      ),
      drawer: AppDrawer(
        loggedUsername: widget.loggedUsername,
        loggedRole: widget.loggedRole,
      ),
      body: Form(
        key: _loginFormKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      username = value!;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      username = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      password1 = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      password1 = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 90,
                height: 35,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    if (_loginFormKey.currentState!.validate()) {
                      // 'username' and 'password' should be the values of the user login form.
                      final response = await request.login(
                          "https://pbp-c04.up.railway.app/autentikasi/login_apk/",
                          {
                            'username': username,
                            'password': password1,
                          });
                      print(request.cookies);
                      if (request.loggedIn) {
                        // Code here will run if the login succeeded.
                        _loginFormKey.currentState!.reset();
                        setState(() {
                          widget.loggedUsername = response["username"];
                          widget.loggedRole = response["role"];
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: '',
                                    loggedUsername: widget.loggedUsername,
                                    loggedRole: widget.loggedRole,
                                  )),
                        );
                      } else {
                        // Code here will run if the login failed (wrong username/password).
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              child: Container(
                                child: ListView(
                                  padding: const EdgeInsets.all(20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Center(
                                      child: Column(children: [
                                        Text(response["message"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16)),
                                      ]),
                                    ),
                                    SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'ok',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum mempunyai akun ? ",
                      style: TextStyle(fontSize: 16)),
                  InkWell(
                    child: Text(
                      "Buat Akun",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              loggedUsername: widget.loggedUsername,
                              loggedRole: widget.loggedRole,
                            )),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
