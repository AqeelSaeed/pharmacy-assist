import 'dart:convert';

class ReturnsModel {
  List<Return>? returns;
  bool? success;

  ReturnsModel({
    this.returns,
    this.success,
  });

  factory ReturnsModel.fromRawJson(String str) =>
      ReturnsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReturnsModel.fromJson(Map<String, dynamic> json) => ReturnsModel(
        returns: json["returns"] == null
            ? []
            : List<Return>.from(
                json["returns"]!.map((x) => Return.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "returns": returns == null
            ? []
            : List<dynamic>.from(returns!.map((x) => x.toJson())),
        "success": success,
      };
}

class Return {
  String? id;
  String? saleId;
  String? pharmacyId;
  String? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

  Return({
    this.id,
    this.saleId,
    this.pharmacyId,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory Return.fromRawJson(String str) => Return.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Return.fromJson(Map<String, dynamic> json) => Return(
        id: json["id"],
        saleId: json["saleId"],
        pharmacyId: json["pharmacyId"],
        totalPrice: json["totalPrice"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "saleId": saleId,
        "pharmacyId": pharmacyId,
        "totalPrice": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
