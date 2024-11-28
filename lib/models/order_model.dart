import 'product_model.dart';

class POSTransactionModel {
  String? transactionId;
  String? customerName;
  List<ProductModel>? productList;
  double? totalAmount;
  bool? isReturned;
  bool? isReturnedAll;
  DateTime? createdAt;
  POSTransactionModel({
    this.customerName,
    this.productList,
    this.totalAmount,
  });

  factory POSTransactionModel.fromJson(Map<String, dynamic> json) =>
      POSTransactionModel(
        customerName: json["customerName"],
        productList: json["productList"] == null
            ? []
            : List<ProductModel>.from(
                json["productList"]!.map((x) => ProductModel.fromJson(x))),
        totalAmount: json["totalAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "productList": productList == null
            ? []
            : List<dynamic>.from(productList!.map((x) => x.toJson())),
        "totalAmount": totalAmount,
      };
}
