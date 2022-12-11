import 'package:flutter/material.dart';
import 'package:donobox/pages/main.dart';
import 'login.dart';
import 'dart:convert';
import '../../drawer/sidebar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:donobox/pages/homepage.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage();
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _regFormKey = GlobalKey<FormState>();
  bool isVisible = false;
  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  String username = "";
  String password1 = "";
  String password2 = "";
  String role = "Donatur";
  List<String> listRole = ['Donatur', 'Fundraiser'];
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    // TODO: implement build
    return Scaffold(
      drawer: const drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3F4E4F),
        title: Text(""),
      ),
      body: Form(
        key: _regFormKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Registrasi Akun",
                style: TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: const TextStyle(color: Color(0xFF3F4E4F)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
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
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      onPressed: toggleVisibility,
                      icon: Icon(isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    labelStyle: const TextStyle(color: Color(0xFF3F4E4F)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: "Repeat Password",
                    suffixIcon: IconButton(
                      onPressed: toggleVisibility,
                      icon: Icon(isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    labelStyle: const TextStyle(color: Color(0xFF3F4E4F)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: Color(0xFF3F4E4F)),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      password2 = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      password2 = value!;
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
              const SizedBox(height: 20),
              const Text("Pilih Role:"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton(
                      value: role,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: listRole.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          role = newValue!;
                        });
                      },
                    ),
                  ]),
              SizedBox(
                width: 90,
                height: 35,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA2CC83)),
                  ),
                  onPressed: () async {
                    if (_regFormKey.currentState!.validate()) {
                      final response = await request.post(
                          "https://pbp-c04.up.railway.app/autentikasi/reg_apk/",
                          {
                            'username': username,
                            'password1': password1,
                            'password2': password2,
                            'role': role,
                          }).then((value) => {
                            if (value['status'])
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                ),
                                request.logout(
                                    "https://pbp-c04.up.railway.app/autentikasi/logout_apk/")
                              }
                            else
                              {
                                if (value['role_error'])
                                  {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    Text(value["message"],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ]),
                                                ),
                                                SizedBox(height: 20),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'ok',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  }
                                else if (value["message"]["username"] != null)
                                  {
                                    print(value["message"]["username"][0]),
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    Text(
                                                        value["message"]
                                                            ["username"][0],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ]),
                                                ),
                                                SizedBox(height: 20),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'ok',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  }
                                else if (value["message"]["password2"] != null)
                                  {
                                    print(value["message"]["password2"][0]),
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                    Text(
                                                        value["message"]
                                                            ["password2"][0],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ]),
                                                ),
                                                SizedBox(height: 20),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'ok',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  }
                              }
                          });
                    }
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
