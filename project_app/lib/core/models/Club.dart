import 'dart:convert';

Club clubFromJson(String str) => Club.fromJson(json.decode(str));

List<Club> clubsFormJson(List lst) => lst.map((e) => clubFromJson(jsonEncode(e))).toList();

String clubToJson(Club data) => json.encode(data.toJson());

class Club {
  Club({
    this.id,
    this.userId,
    this.title,
    this.detail,
    this.photoPath,
    this.open,
    this.googleMap,
    this.add,
    this.price,
    this.tel,
  });

  int id;
  int userId;
  String title;
  String detail;
  String photoPath;
  String open;
  String googleMap;
  String add;
  String price;
  String tel;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    userId: json["userId"],
    title: json["Title"],
    detail: json["detail"],
    photoPath: json["photoPath"],
    open: json["open"],
    googleMap: json["googleMap"],
    add: json["add"],
    price: json["price"],
    tel: json["tel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "Title": title,
    "detail": detail,
    "photoPath": photoPath,
    "open": open,
    "googleMap": googleMap,
    "add": add,
    "price": price,
    "tel": tel,
  };
}