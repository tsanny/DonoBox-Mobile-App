// To parse this JSON data, do
//
//     final artikel = artikelFromJson(jsonString);

import 'dart:convert';

List<Artikel> artikelFromJson(String str) =>
    List<Artikel>.from(json.decode(str).map((x) => Artikel.fromJson(x)));

String artikelToJson(List<Artikel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Artikel {
  Artikel({
    required this.id,
    required this.userId,
    required this.date,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.author,
    required this.timeDiff,
  });

  int id;
  int userId;
  DateTime date;
  String title;
  String shortDescription;
  String description;
  String author;
  String timeDiff;

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
        id: json["id"],
        userId: json["user_id"],
        date: DateTime.parse(json["date"]),
        title: json["title"],
        shortDescription: json["short_description"],
        description: json["description"],
        author: json["author"],
        timeDiff: json["time_diff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "date": date.toIso8601String(),
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "author": author,
        "time_diff": timeDiff,
      };
}
