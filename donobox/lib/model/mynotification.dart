// To parse this JSON data, do
//
//     final myNotification = myNotificationFromJson(jsonString);

import 'dart:convert';

List<MyNotification> myNotificationFromJson(String str) => List<MyNotification>.from(json.decode(str).map((x) => MyNotification.fromJson(x)));

String myNotificationToJson(List<MyNotification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyNotification {
    MyNotification({
        required this.model,
        required this.pk,
        required this.fields,
    });

    String model;
    int pk;
    Fields fields;

    factory MyNotification.fromJson(Map<String, dynamic> json) => MyNotification(
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
        required this.user,
        required this.title,
        required this.description,
        required this.time,
        required this.timesince,
    });

    int user;
    String title;
    String description;
    DateTime time;
    String timesince;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        description: json["description"],
        time: DateTime.parse(json["time"]),
        timesince: json["timesince"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "description": description,
        "time": time.toIso8601String(),
        "timesince": timesince,
    };
}
