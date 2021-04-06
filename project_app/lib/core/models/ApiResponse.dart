import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Object data;


  @override
  String toString() {
    return 'ApiResponse{status: $status, message: $message, data: $data}';
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    status: json['status'],
    message: json['message'],
    data: json['data'],
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data,
  };
}

