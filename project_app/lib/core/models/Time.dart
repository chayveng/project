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
    this.status,
  });

  int? id;
  int? fieldId;
  int? userId;
  DateTime? startTime;
  DateTime? endTime;
  bool? status;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        id: json["id"],
        fieldId: json["fieldId"],
        userId: json["userId"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fieldId": fieldId,
        "userId": userId,
        "startTime": startTime,
        "endTime": endTime,
        "status": status,
      };

  @override
  String toString() {
    return 'Time{id: $id, fieldId: $fieldId, userId: $userId, startTime: $startTime, endTime: $endTime, status: $status}';
  }
}
