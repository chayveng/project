import 'dart:convert';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  Field({
    this.id,
    this.clubId,
    this.title,
  });

  int id;
  int clubId;
  String title;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    clubId: json["clubId"],
    title: json["fieldName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubId": clubId,
    "fieldName": title,
  };
}
