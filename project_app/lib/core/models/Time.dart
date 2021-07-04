import 'dart:convert';

Time timeFromJson(String str) => Time.fromJson(json.decode(str));

List<Time> timesFormJson(List lst) =>
    lst.map((e) => timeFromJson(jsonEncode(e))).toList();

String timeToJson(Time data) => json.encode(data.toJson());

class Time {
  Time({
    this.id,
    this.fieldId,
    this.userId,
    this.startTime,
    this.endTime,
  });

  int? id;
  int? fieldId;
  int? userId;
  String? startTime;
  String? endTime;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        fieldId: json["fieldId"],
        userId: json["userId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fieldId": fieldId,
        "userId": userId,
        "startTime": startTime,
        "endTime": endTime,
      };

  @override
  String toString() {
    return 'Time{id: $id, fieldId: $fieldId, userId: $userId, startTime: $startTime, endTime: $endTime}';
  }
}
