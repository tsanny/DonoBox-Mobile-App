import 'dart:convert';

import 'package:donobox/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../drawer/sidebar.dart';
import '../model/faq_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class AskUsPage extends StatefulWidget {
  const AskUsPage({Key? key}) : super(key: key);

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
        drawer: const drawer(),
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
                                  builder: (context) => const LoginPage()),
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
                  Expanded(
                      child: FutureBuilder(
                          future: fetchFaq(),
                          builder: (context, AsyncSnapshot<List<Faq>> snapshot){
                            if (snapshot.data == null) {
                              return const Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.data!.isEmpty){
                                return Column(
                                  children: const [
                                    SizedBox(height: 8),
                                  ],
                                );
                              } else{
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index){
                                        return Container(
                                          margin: new EdgeInsets.fromLTRB(0, 0, 0, 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
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
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    snapshot.data![index].user,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xFF879999),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child: Text(
                                                    snapshot.data![index].pertanyaan,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data![index].jawaban,
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                );
                              }
                            }
                          })
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
