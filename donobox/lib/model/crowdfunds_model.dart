// To parse this JSON data, do
//
//     final crowdfunds = crowdfundsFromJson(jsonString);

import 'dart:convert';

List<Crowdfunds> crowdfundsFromJson(String str) => List<Crowdfunds>.from(json.decode(str).map((x) => Crowdfunds.fromJson(x)));

String crowdfundsToJson(List<Crowdfunds> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Crowdfunds {
    Crowdfunds({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory Crowdfunds.fromJson(Map<String, dynamic> json) => Crowdfunds(
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
        required this.fundraiser,
        required this.fundraiserName,
        required this.title,
        required this.description,
        required this.collected,
        required this.target,
        required this.deadline,
    });

    int fundraiser;
    String fundraiserName;
    String title;
    String description;
    int collected;
    int target;
    DateTime deadline;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        fundraiser: json["fundraiser"],
        fundraiserName: json["fundraiser_name"],
        title: json["title"],
        description: json["description"],
        collected: json["collected"],
        target: json["target"],
        deadline: DateTime.parse(json["deadline"]),
    );

    Map<String, dynamic> toJson() => {
        "fundraiser": fundraiser,
        "fundraiser_name": fundraiserName,
        "title": title,
        "description": description,
        "collected": collected,
        "target": target,
        "deadline": deadline.toIso8601String(),
    };
}
