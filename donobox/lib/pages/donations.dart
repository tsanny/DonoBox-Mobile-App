import 'package:donobox/model/donations_model.dart';
import 'package:donobox/pages/crowdfund.dart';
import 'package:donobox/drawer/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DonationsPage extends StatelessWidget {
  const DonationsPage({
    super.key,
    required this.loggedUsername,
    required this.loggedRole,
    required this.id,
    required this.title,
    required this.fundraiserName,
    required this.description,
    required this.collected,
    required this.target,
    required this.deadline,
  });

  final String loggedUsername;
  final String loggedRole;
  final int id;
  final String title;
  final String fundraiserName;
  final String description;
  final int collected;
  final int target;
  final DateTime deadline;

  Future<List<Donations>> fetchDonations(request) async {
    var data = await request.get('https://pbp-c04.up.railway.app/crowdfund/donations/json/$id/');
    List<Donations> listDonations = [];
    for (var d in data) {
      if (d != null) {
        listDonations.add(Donations.fromJson(d));
      }
    }
    return listDonations;
  }

  String determineComment(comment) {
    if (comment == '') {
      return 'Donatur tidak memberikan komentar.';
    }
    return comment;
  }

@override
  Widget build(BuildContext context) {
    final request = context.read<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F4E4F),
        title: const Text('Donasi Terkumpul')
      ),
      drawer: drawer(
        loggedUsername: loggedUsername,
        loggedRole: loggedRole,
      ),
      body: FutureBuilder(
        future: fetchDonations(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.length == 0) {
              return Container(
                alignment: Alignment.center,
                child: const Text('Belum ada donasi yang terkumpul.'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => InkWell(
                child: Column(
                  children: [
                    const Text(''),
                    Text(
                      '${snapshot.data![index].fields.donatorName} mendonasikan ${snapshot.data![index].fields.amount}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(determineComment(snapshot.data![index].fields.comment)),
                  ],
                ),
              ),
            );
          }
        }
      ),




      bottomSheet: Container(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CrowdfundPage(
                  loggedUsername: loggedUsername,
                  loggedRole: loggedRole,
                  id: id,
                  title: title,
                  fundraiserName: fundraiserName,
                  description: description,
                  collected: collected,
                  target: target,
                  deadline: deadline,
                ),
              ),
            );
          },
          child: const Text('Kembali'),
        ),
      ),
    );
  }
}