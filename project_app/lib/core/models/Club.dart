import 'dart:convert';

Club clubFromJson(String str) => Club.fromJson(json.decode(str));

List<Club> clubsFormJson(List lst) =>
    lst.map((e) => clubFromJson(jsonEncode(e))).toList();

String clubToJson(Club data) => json.encode(data.toJson());

class Club {
  Club({
    this.id,
    this.userId,
    this.title,
    this.detail,
    this.address,
    this.open,
    this.price,
    this.tel,
    this.map,
    this.photosPath,
  });

  int id;

  int userId;
  String title;
  String detail;
  dynamic address;
  dynamic open;
  dynamic price;
  dynamic tel;
  dynamic map;
  String photosPath;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        detail: json["detail"],
        address: json["address"],
        open: json["open"],
        price: json["price"],
        tel: json["tel"],
        map: json["map"],
        photosPath: json["photosPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "detail": detail,
        "address": address,
        "open": open,
        "price": price,
        "tel": tel,
        "map": map,
        "photosPath": photosPath,
      };

  @override
  String toString() {
    return 'Club{id: $id, userId: $userId, title: $title, detail: $detail, address: $address, open: $open, price: $price, tel: $tel, map: $map, photosPath: $photosPath}';
  }
}
