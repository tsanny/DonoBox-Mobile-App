import 'dart:convert';
import 'package:donobox/page/crowdfund.dart';
import 'package:donobox/page/drawer.dart';
import 'package:donobox/page/login.dart';
import 'package:donobox/model/crowdfunds_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CrowdfundsPage extends StatelessWidget {
  const CrowdfundsPage({
    super.key,
    required this.loggedUsername,
    required this.loggedRole,
  });

  final String loggedUsername;
  final String loggedRole;

  Text showGreeting(request) {
    String greeting = "";
    if (!request.loggedIn) {
      greeting = 'Login untuk melihat detail dan berdonasi kepada orang-orang yang membutuhkan';
    } else if (loggedRole == 'Donatur') {
      greeting = 'Ayo berdonasi kepada orang-orang yang membutuhkan, $loggedUsername';
    } else {
      greeting = 'Berikut adalah galangan dana yang Anda ajukan, $loggedUsername';
    }
    return Text(
      greeting,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15),
    );
  }

  Future<List<Crowdfunds>> fetchCrowdfunds(request) async {
    String url = '';
    if (!request.loggedIn || loggedUsername == 'Donatur') {
      url = 'https://pbp-c04.up.railway.app/crowdfund/funds/json/ongoing/';
    } else {
      url = 'https://pbp-c04.up.railway.app/crowdfund/flutter/funds/${loggedUsername}/';
    }
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json',
      },
    );
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Crowdfunds> listCrowdfunds = [];
    for (var d in data) {
      if (d != null) {
        listCrowdfunds.add(Crowdfunds.fromJson(d));
      }
    }
    return listCrowdfunds;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Galangan Dana'),
      ),
      drawer: AppDrawer(
        loggedUsername: loggedUsername,
        loggedRole: loggedRole,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              child: showGreeting(request),
            ),
          ),
          Expanded(
            flex: 7,
            child: FutureBuilder(
              future: fetchCrowdfunds(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.data!.length == 0) {
                    if (loggedRole == 'Fundraiser') {
                      return Container(
                        alignment: Alignment.center,
                        child: const Text('Anda belum mengajukan galangan dana.'),
                      );
                    }
                    return Container(
                      alignment: Alignment.center,
                      child: const Text('Belum ada galangan dana yang sedang berlangsung saat ini.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        if (!request.loggedIn) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                loggedUsername: loggedUsername,
                                loggedRole: loggedRole,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CrowdfundPage(
                                loggedUsername: loggedUsername,
                                loggedRole: loggedRole,
                                id: snapshot.data![index].pk,
                                title: snapshot.data![index].fields.title,
                                fundraiserName: snapshot.data![index].fields.fundraiserName,
                                description: snapshot.data![index].fields.description,
                                collected: snapshot.data![index].fields.collected,
                                target: snapshot.data![index].fields.target,
                                deadline: snapshot.data![index].fields.deadline,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 10.0,
                          left: 10.0,
                          right: 10.0),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Column(
                          children: [
                            Text(snapshot.data![index].fields.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Digalang oleh ${snapshot.data![index].fields.fundraiserName}'),
                            Text('${snapshot.data![index].fields.collected} terkumpul - ${snapshot.data![index].fields.target} dibutuhkan'),
                            Text('hingga ${snapshot.data![index].fields.deadline}'),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ); 
  }
}