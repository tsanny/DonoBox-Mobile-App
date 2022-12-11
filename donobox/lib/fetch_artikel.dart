import 'model/artikel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Artikel>> fetchArtikel() async {
  var url =
      Uri.parse('https://pbp-c04.up.railway.app/artikel/show_json_flutter');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Artikel> listArtikel = [];
  for (var d in data) {
    if (d != null) {
      listArtikel.add(Artikel.fromJson(d));
    }
  }

  return listArtikel;
}
