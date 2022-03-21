import 'dart:convert';

Time timeFromJson(String str) => Time.fromJson(json.decode(str));

List<Time> timesFromJson(List lst) =>
    lst.map((e) => timeFromJson(jsonEncode(e))).toList();

String timeToJson(Time data) => json.encode(data.toJson());

String timeGetDate(String str) => str.substring(0, 10);

String timeGetTime(String str) => str.substring(11, 16);

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
  String? startTime;
  String? endTime;
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

  String getDate()=> startTime.toString().substring(0,10);
  String getStartTime()=> startTime.toString().substring(11,16);
  String getEndTime()=> endTime.toString().substring(11,16);

  @override
  String toString() {
    return 'Time{id: $id, fieldId: $fieldId, userId: $userId, startTime: $startTime, endTime: $endTime, status: $status}';
  }
}
