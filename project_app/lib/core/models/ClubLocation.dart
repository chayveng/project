import 'dart:convert';

ClubLocation clubLocationFromJson(String str) => ClubLocation.fromJson(json.decode(str));

String clubLocationToJson(ClubLocation data) => json.encode(data.toJson());

class ClubLocation {
  ClubLocation({
    this.id,
    this.clubId,
    this.latitude,
    this.longitude,
  });

  int? id;
  int? clubId;
  double? latitude;
  double? longitude;

  factory ClubLocation.fromJson(Map<String, dynamic> json) => ClubLocation(
    id: json["id"],
    clubId: json["clubId"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "clubId": clubId,
    "latitude": latitude,
    "longitude": longitude,
  };

  @override
  String toString() {
    return 'ClubLocation{clubId: $clubId, latitude: $latitude, longitude: $longitude}';
  }
}
