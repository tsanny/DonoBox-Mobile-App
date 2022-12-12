// To parse this JSON data, do
//
//     final donations = donationsFromJson(jsonString);

import 'dart:convert';

List<Donations> donationsFromJson(String str) => List<Donations>.from(json.decode(str).map((x) => Donations.fromJson(x)));

String donationsToJson(List<Donations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donations {
    Donations({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Donations.fromJson(Map<String, dynamic> json) => Donations(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.donator,
        required this.donatorName,
        required this.crowdfund,
        required this.amount,
        required this.comment,
    });

    int donator;
    String donatorName;
    int crowdfund;
    int amount;
    String comment;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        donator: json["donator"],
        donatorName: json["donator_name"],
        crowdfund: json["crowdfund"],
        amount: json["amount"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "donator": donator,
        "donator_name": donatorName,
        "crowdfund": crowdfund,
        "amount": amount,
        "comment": comment,
    };
}
