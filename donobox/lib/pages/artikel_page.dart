import 'package:flutter/material.dart';
import '../model/artikel.dart';
import 'artikel_detail_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../fetch_artikel.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'login.dart';
import '../../drawer/sidebar.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({
    Key? key,
    required this.loggedUsername,
    required this.loggedRole,
  }) : super(key: key);

  final String loggedUsername;
  final String loggedRole;

  @override
  _ArtikelState createState() => _ArtikelState();
}

class _ArtikelState extends State<ArtikelPage> {
  final _artikelFormKey = GlobalKey<FormState>();

  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F4E4F),
        title: const Text('Article'),
      ),
      drawer: drawer(
        loggedUsername: widget.loggedUsername,
        loggedRole: widget.loggedRole,
      ),
      body: FutureBuilder(
          future: fetchArtikel(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Artikel",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, blurRadius: 2.0)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].title}",
                                  style: const TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(snapshot.data![index].timeDiff
                                            .compareTo("0 seconds ago") !=
                                        0
                                    ? "${snapshot.data![index].timeDiff}"
                                    : "Just now"),
                                Text(
                                    "${snapshot.data![index].shortDescription} ..."),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtikelDetailPage(
                                    artikel: snapshot.data![index],
                                    loggedUsername: widget.loggedUsername,
                                    loggedRole: widget.loggedRole,
                                ),
                              ),
                            );
                          },
                        ));
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFA2CC83),
        onPressed: (() {
          !request.loggedIn
              ? showDialog(
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
                                Text("Anda harus login terlebih dahulu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16)),
                              ]),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                        loggedUsername: widget.loggedUsername,
                                        loggedRole: widget.loggedRole,
                                      )),
                                );
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
                )
              : showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                        body: Form(
                            key: _artikelFormKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(20.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Buat Artikel Baru",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ]),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: "Judul",
                                          labelStyle: const TextStyle(
                                              color: Color(0xFF3F4E4F)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF3F4E4F)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF3F4E4F)),
                                          ),
                                        ),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Judul Tidak Boleh Kosong';
                                          }
                                          return null;
                                        },
                                        onChanged: (String? value) {
                                          setState(() {
                                            title = value!;
                                          });
                                        },
                                        onSaved: ((String? value) {
                                          setState(() {
                                            title = value!;
                                          });
                                        }),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Deskripsi",
                                        labelStyle: const TextStyle(
                                            color: Color(0xFF3F4E4F)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF3F4E4F)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF3F4E4F)),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Deskripsi Tidak Boleh Kosong!';
                                        }
                                        return null;
                                      },
                                      onChanged: (String? value) {
                                        setState(() {
                                          description = value!;
                                        });
                                      },
                                      onSaved: (String? value) {
                                        setState(() {
                                          description = value!;
                                        });
                                      },
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFA2CC83),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            padding: const EdgeInsets.all(16.0),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.center,
                                          ),
                                          onPressed: () async {
                                            if (_artikelFormKey.currentState!
                                                .validate()) {
                                              final response = await request.post(
                                                  "https://pbp-c04.up.railway.app/artikel/add/",
                                                  {
                                                    'title': title,
                                                    'description': description
                                                  }).then((value) => {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ArtikelPage(
                                                                loggedUsername: widget.loggedUsername,
                                                                loggedRole: widget.loggedRole,
                                                              )),
                                                    )
                                                  });
                                            }
                                          },
                                          child: const Text("Buat!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            backgroundColor: Color(0xFFA2CC83),
                                            padding: const EdgeInsets.all(16.0),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            alignment: Alignment.center,
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                              ArtikelPage(
                                                                loggedUsername: widget.loggedUsername,
                                                                loggedRole: widget.loggedRole,
                                                              )),
                                          ),
                                          child: const Text("Kembali",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // make button back
                                ],
                              ),
                            )));
                  });

          ;
        }),
        tooltip: 'Tambah Artikel',
        child: const Icon(Icons.add),
      ),
    );
  }
}
