import 'dart:convert';

class DrugDepotModel {
  List<DrugDepot>? drugDepot;
  bool? success;

  DrugDepotModel({
    this.drugDepot,
    this.success,
  });

  factory DrugDepotModel.fromRawJson(String str) =>
      DrugDepotModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrugDepotModel.fromJson(Map<String, dynamic> json) => DrugDepotModel(
        drugDepot: json["drugDepot"] == null
            ? []
            : List<DrugDepot>.from(
                json["drugDepot"]!.map((x) => DrugDepot.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "drugDepot": drugDepot == null
            ? []
            : List<dynamic>.from(drugDepot!.map((x) => x.toJson())),
        "success": success,
      };
}

class DrugDepot {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? profilePicture;
  String? certificate;
  String? address;
  int? totalProducts;
  String? role;
  int? isDeleted;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isSelfCreated;

  DrugDepot({
    this.id,
    this.uid,
    this.name,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.profilePicture,
    this.certificate,
    this.address,
    this.totalProducts,
    this.role,
    this.isDeleted,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isSelfCreated,
  });

  factory DrugDepot.fromRawJson(String str) =>
      DrugDepot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DrugDepot.fromJson(Map<String, dynamic> json) => DrugDepot(
        id: json["id"] ?? '',
        uid: json["uid"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        countryCode: json["countryCode"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        profilePicture: json["profilePicture"] ?? '',
        certificate: json["certificate"] ?? '',
        address: json["address"] ?? '',
        totalProducts: json["totalProducts"] ?? 0,
        role: json["role"] ?? '',
        isDeleted: json["isDeleted"] ?? 0,
        isActive: json["isActive"] ?? 0,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isSelfCreated: json["isSelfCreated"],
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
        "totalProducts": totalProducts,
        "role": role,
        "isDeleted": isDeleted,
        "isActive": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "isSelfCreated": isSelfCreated,
      };
}
