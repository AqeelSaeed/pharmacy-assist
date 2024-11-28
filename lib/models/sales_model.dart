import 'package:pharmacy_assist/main_barrel.dart';

class Sale {
  String? saleId;
  String? customerName;
  List<ProductModel>? productList;
  DateTime? createdAt;
  int? isReturned;
  int? isReturnedAll;
  double? totalAmount;

  Sale({
    this.saleId,
    this.customerName,
    this.productList,
    this.createdAt,
    this.isReturned,
    this.isReturnedAll,
    this.totalAmount,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      saleId: json['saleId'],
      customerName: json['customerName'],
      productList: (json['productList'] as List?)
          ?.map((product) => ProductModel.fromJson(product))
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      isReturned: json['isReturned'],
      isReturnedAll: json['isReturnedAll'],
      totalAmount: json['totalAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'saleId': saleId,
      'customerName': customerName,
      'productList': productList?.map((product) => product.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
      'isReturned': isReturned,
      'isReturnedAll': isReturnedAll,
      'totalAmount': totalAmount,
    };
  }
}
