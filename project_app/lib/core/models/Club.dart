import 'dart:convert';

Club clubFromJson(String str) => Club.fromJson(json.decode(str));

List<Club> clubsFormJson(List lst) => lst.map((e) => clubFromJson(jsonEncode(e))).toList();

String clubToJson(Club data) => json.encode(data.toJson());

class Club {
  Club({
    this.id,
    this.userId,
    this.clubName,
    this.detail,
    this.map,
    this.tel,
  });

  int id;
  int userId;
  String clubName;
  String detail;
  String map;
  String tel;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    userId: json["userId"],
    clubName: json["clubName"],
    detail: json["detail"],
    map: json["map"],
    tel: json["tel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "clubName": clubName,
    "detail": detail,
    "map": map,
    "tel": tel,
  };
}
