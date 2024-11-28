import 'dart:convert';

class SignupResponseModel {
  String message;
  String email;
  String role;
  bool success;

  SignupResponseModel({
    required this.message,
    required this.email,
    required this.role,
    required this.success,
  });

  factory SignupResponseModel.fromRawJson(String str) =>
      SignupResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
        message: json["message"],
        email: json["email"],
        role: json["role"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "email": email,
        "role": role,
        "success": success,
      };
}
