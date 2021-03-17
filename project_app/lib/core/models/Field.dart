import 'dart:convert';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  Field({
    this.id,
    this.clubId,
    this.fieldName,
  });

  int id;
  int clubId;
  String fieldName;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    id: json["id"],
    clubId: json["clubId"],
    fieldName: json["fieldName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "clubId": clubId,
    "fieldName": fieldName,
  };
}
