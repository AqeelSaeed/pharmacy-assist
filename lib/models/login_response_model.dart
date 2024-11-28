import 'dart:convert';

class LoginModel {
  String? message;
  bool? success;
  User? user;
  String? token;

  LoginModel({
    this.message,
    this.success,
    this.user,
    this.token,
  });

  factory LoginModel.fromRawJson(String str) =>
      LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? countryCode;
  String? phoneNumber;
  dynamic profilePicture;
  String? certificate;
  String? address;
  String? role;
  int? totalProducts;
  int? isDeleted;
  int? isActive;
  int? isSelfCreated;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? ownerName;

  User({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.profilePicture,
    this.certificate,
    this.address,
    this.role,
    this.totalProducts,
    this.isDeleted,
    this.isActive,
    this.isSelfCreated,
    this.createdAt,
    this.updatedAt,
    this.ownerName,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        profilePicture: json["profilePicture"],
        certificate: json["certificate"],
        address: json["address"],
        role: json["role"],
        totalProducts: json["totalProducts"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
        isSelfCreated: json["isSelfCreated"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        ownerName: json["ownerName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "name": name,
        "email": email,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "profilePicture": profilePicture,
        "certificate": certificate,
        "address": address,
        "role": role,
        "totalProducts": totalProducts,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "isSelfCreated": isSelfCreated,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "ownerName": ownerName,
      };
}
