import 'dart:convert';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

List<Field> fieldsFormJson(List lst) =>
    lst.map((e) => fieldFromJson(jsonEncode(e))).toList();

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  Field({
    this.id,
    this.clubId,
    this.title,
    this.detail,
    this.price,
  });

  int id;
  int clubId;
  String title;
  String detail;
  String price;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        clubId: json["clubId"],
        title: json["title"],
        detail: json["detail"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clubId": clubId,
        "title": title,
        "detail": detail,
        "price": price,
      };

  Map<String, dynamic> toMap() {
    return {"test": ""};
  }

  @override
  String toString() {
    return 'Field{id: $id, clubId: $clubId, title: $title, detail: $detail, price: $price}';
  }
}
