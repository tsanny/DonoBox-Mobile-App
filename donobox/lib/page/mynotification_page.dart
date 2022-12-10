import 'package:donobox/main.dart';
import 'package:donobox/model/mynotification.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class MyNotificationPage extends StatefulWidget {
  const MyNotificationPage({ super.key });

  @override
  _MyNotificationPageState createState() => _MyNotificationPageState();
}

class _MyNotificationPageState extends State<MyNotificationPage> {
    Future<List<MyNotification>> fetchMyNotification() async {
        var url = Uri.parse('http://127.0.0.1:8000/notification/json/'); // RECONFIGURE BEFORE PUSHING TO REPO
        var response = await http.get(
        url,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        );

        // melakukan decode response menjadi bentuk json
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        // melakukan konversi data json menjadi object MyNotification
        List<MyNotification> listMyNotification = [];
        for (var d in data) {
        if (d != null) {
            listMyNotification.add(MyNotification.fromJson(d));
        }
        }

        return listMyNotification;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('My Notification'),
            ),
            drawer: Drawer(
                child: Column(
                  children: [
                    // Menambahkan clickable menu
                    ListTile(
                      title: const Text('donobox'),
                      onTap: () {
                        // Route menu ke halaman utama
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('My Notification'),
                      onTap: () {
                        // Route menu ke halaman Notification
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyNotificationPage()),
                        );
                      },
                    ),
                  ],
                ),
            ),
            body: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FutureBuilder(
                      future: fetchMyNotification(),
                      builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                          return const Center(child: CircularProgressIndicator());
                          } else {
                          if (!snapshot.hasData) {
                              return Column(
                              children: const [
                                  Text(
                                  "Tidak ada Notification :(",
                                  style: TextStyle(
                                      color: Color(0xff59A5D8),
                                      fontSize: 20),
                                  ),
                                  SizedBox(height: 8),
                              ],
                              );
                          } else {
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (_, index)=> InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 2.0
                                            )
                                          ]
                                      ),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text("${snapshot.data![index].fields.title}"),
                                              subtitle: Text("${snapshot.data![index].fields.description}"),
                                              trailing: Text("${snapshot.data![index].fields.timesince}"),
                                            ),
                                          // Text(
                                          //     "${snapshot.data![index].fields.title}",
                                          //     style: const TextStyle(
                                          //     fontSize: 18.0,
                                          //     ),
                                          // ),
                                          ],
                                        ),
                                      ),
                                      // onTap: () {
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => MyNotificationDetailPage(notification: snapshot.data[index]),
                                      //     ),
                                      //   );
                                      // },
                                  )
                              );
                          }
                          }
                      }
                  )
            )
        );
    }
}