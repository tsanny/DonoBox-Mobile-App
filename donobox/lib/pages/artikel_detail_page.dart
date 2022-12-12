import '../model/artikel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../drawer/sidebar.dart';

class ArtikelDetailPage extends StatelessWidget {
  final Artikel artikel;
  final String loggedUsername;
  final String loggedRole;

  const ArtikelDetailPage({
    Key? key,
    required this.artikel,
    required this.loggedUsername,
    required this.loggedRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMM dd, yyyy');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F4E4F),
        title: const Text('Detail'),
      ),
        drawer: drawer(
          loggedUsername: loggedUsername,
          loggedRole: loggedRole,
        ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        artikel.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          "Dibuat oleh ${artikel.author} pada ${formatter.format(DateTime.parse(artikel.date.toString().substring(0, 10)))}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        dense: true,
                      ),
                      ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            artikel.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        dense: true,
                      )
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFA2CC83),
                        padding: const EdgeInsets.all(15.0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
