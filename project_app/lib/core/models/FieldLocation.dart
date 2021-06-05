import 'dart:convert';

FieldLocation fieldLocationFromJson(String str) => FieldLocation.fromJson(json.decode(str));

String fieldLocationToJson(FieldLocation data) => json.encode(data.toJson());

class FieldLocation {
  FieldLocation({
    this.id,
    this.fieldId,
    this.lat,
    this.lng,
  });

  int id;
  int fieldId;
  double lat;
  double lng;

  factory FieldLocation.fromJson(Map<String, dynamic> json) => FieldLocation(
    id: json["id"],
    fieldId: json["fieldId"],
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fieldId": fieldId,
    "lat": lat,
    "lng": lng,
  };

  @override
  String toString() {
    return 'FieldLocation{id: $id, fieldId: $fieldId, lat: $lat, lng: $lng}';
  }
}