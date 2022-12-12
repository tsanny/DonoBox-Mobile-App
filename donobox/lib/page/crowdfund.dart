import 'package:donobox/page/crowdfunds.dart';
import 'package:donobox/page/drawer.dart';
import 'package:donobox/page/donations.dart';
import 'package:flutter/material.dart';

class CrowdfundPage extends StatelessWidget {
  const CrowdfundPage({
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

  String determineDescription() {
    if (description == '') {
      return 'Galangan dana ini tidak memiliki deskripsi.';
    }
    return description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: AppDrawer(
        loggedUsername: loggedUsername,
        loggedRole: loggedRole,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Judul Galangan Dana',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(title),
          const Text(''),
          const Text(
            'Pengaju Galangan Dana',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(fundraiserName),
          const Text(''),
          const Text(
            'Jumlah Dana Terkumpul',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(collected.toString()),
          const Text(''),
          const Text(
            'Target Dana Terkumpul',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(target.toString()),
          const Text(''),
          const Text(
            'Batas Waktu Pengumpulan Dana',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(deadline.toString()),
          const Text(''),
          const Text(
            'Informasi Lebih Lanjut',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(determineDescription()),
          const Text(''),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationsPage(
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
            child: const Text('Donasi Terkumpul'),
          )
        ],
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
                builder: (context) => CrowdfundsPage(
                  loggedUsername: loggedUsername,
                  loggedRole: loggedRole,
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