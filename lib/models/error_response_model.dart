import 'dart:convert';

class ErrorResponseModel {
  String error;
  bool success;

  ErrorResponseModel({
    required this.error,
    required this.success,
  });

  factory ErrorResponseModel.fromRawJson(String str) =>
      ErrorResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      ErrorResponseModel(
        error: json["error"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "success": success,
      };
}
