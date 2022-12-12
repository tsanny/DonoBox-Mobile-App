import 'dart:convert';

import 'package:donobox/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../drawer/sidebar.dart';
import '../model/faq_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ListPertanyaan extends StatefulWidget {
  const ListPertanyaan({Key? key}) : super(key: key);

  @override
  State<ListPertanyaan> createState() => _ListPertanyaanState();
}

class _ListPertanyaanState extends State<ListPertanyaan> {

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
        body:
        FutureBuilder(
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
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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
            }),

    );
  }
}
