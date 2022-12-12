import 'dart:convert';

import 'package:donobox/pages/ListPertanyaan.dart';
import 'package:donobox/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../drawer/sidebar.dart';
import '../model/faq_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class AskUsPage extends StatefulWidget {
  const AskUsPage({
    Key? key,
    required this.loggedUsername,
    required this.loggedRole,
  }) : super(key: key);

  final String loggedUsername;
  final String loggedRole;

  @override
  State<AskUsPage> createState() => _AskUsPageState();
}

class _AskUsPageState extends State<AskUsPage> {
  final _formKey = GlobalKey<FormState>();
  String _pertanyaan = "";


  Future<List<Faq>> fetchFaq() async{
    var url = 'https://pbp-c04.up.railway.app/json/';
    var response = await http.get(
        Uri.parse(url),
    );

    // Melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // Melakukan konversi data json menjadi object MyWatchList
    List<Faq> listMyWatchList = [];
    for (var d in data) {
      if (d != null) {
        listMyWatchList.add(Faq.fromJson(d["fields"]));
      }
    }
    return listMyWatchList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF3F4E4F),
        ),
        drawer: drawer(
          loggedUsername: widget.loggedUsername,
          loggedRole: widget.loggedRole,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (request.loggedIn)
                  Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      // Menambahkan behavior saat nama diketik
                      onChanged: (String? value) {
                        setState(() {
                          _pertanyaan = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          _pertanyaan = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Ups, kamu tidak bertanya apapun.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  if(!request.loggedIn)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: const Text(
                            "Login ",
                            style: TextStyle(color: Color(0xFFA2CC83), fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                    loggedUsername: widget.loggedUsername,
                                    loggedRole: widget.loggedRole,
                                  )),
                            );
                          },
                        ),
                        const Text("untuk bertanya ",
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  const SizedBox(height: 40),
                  if (request.loggedIn)
                  Center(
                    child: MaterialButton(
                      color: Color(0xFFA2CC83),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                          side: BorderSide(color: Color(0xFFDCF5E6))),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Feedback Berhasil dikirim!')),
                        );
                        print("Data");
                        print("Pertanyaan: " + _pertanyaan!);
                        final response = await http.post(
                            Uri.parse("https://pbp-c04.up.railway.app/faq_flutter/"),
                            headers: <String, String>{
                              'Content-Type': 'application/json;charset=UTF-8'
                            },
                            body: jsonEncode(<String, String>{
                              'pertanyaan': _pertanyaan!,
                            }));
                        print(response);
                        setState(() {

                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "Kirim",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      color: Color(0xFFA2CC83),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14.0)),
                          side: BorderSide(color: Color(0xFFDCF5E6))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListPertanyaan()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          "Liat Pertanyaan",
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
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
