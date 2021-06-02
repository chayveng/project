import 'dart:convert';

Field fieldFromJson(String str) => Field.fromJson(json.decode(str));

List<Field> fieldsFromJson(List lst) =>
    lst.map((e) => fieldFromJson(jsonEncode(e))).toList();

String fieldToJson(Field data) => json.encode(data.toJson());

class Field {
  Field({
    this.id,
    this.userId,
    this.title,
    this.detail,
    this.address,
    this.tel,
    this.hours,
    this.price,
  });

  int id;
  int userId;
  String title;
  String detail;
  String address;
  String tel;
  String hours;
  String price;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        detail: json["detail"],
        address: json["address"],
        tel: json["tel"],
        hours: json["hours"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "detail": detail,
        "address": address,
        "tel": tel,
        "hours": hours,
        "price": price,
      };

  @override
  String toString() {
    return 'Field{id: $id, userId: $userId, title: $title, detail: $detail, address: $address, tel: $tel, hours: $hours, price: $price}';
  }
}
