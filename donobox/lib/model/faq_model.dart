// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

Faq faqFromJson(String str) => Faq.fromJson(json.decode(str));

String faqToJson(Faq data) => json.encode(data.toJson());

class Faq {
  Faq({
    required this.user,
    required this.pertanyaan,
    required this.jawaban,
  });

  String user;
  String pertanyaan;
  String jawaban;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    user: json["user"],
    pertanyaan: json["pertanyaan"],
    jawaban: json["jawaban"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "pertanyaan": pertanyaan,
    "jawaban": jawaban,
  };
}
