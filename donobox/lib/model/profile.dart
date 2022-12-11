import 'dart:convert';

// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);


List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    required this.picture,
    this.bio,
    required this.role,
    required this.saldo,
    this.birthday,
    this.email,
    this.phone,
  });

  int user;
  String picture;
  dynamic bio;
  String role;
  int saldo;
  dynamic birthday;
  dynamic email;
  dynamic phone;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    picture: json["picture"],
    bio: json["bio"],
    role: json["role"],
    saldo: json["saldo"],
    birthday: json["birthday"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "picture": picture,
    "bio": bio,
    "role": role,
    "saldo": saldo,
    "birthday": birthday,
    "email": email,
    "phone": phone,
  };
}

