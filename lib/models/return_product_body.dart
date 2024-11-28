class ReturnProductBody {
  String productId;
  int boxQuantity;
  int sheetQuantity;
  double productSheetPrice;
  double productBoxPrice;
  double totalBoxPrice;
  double totalSheetPrice;

  ReturnProductBody({
    required this.productId,
    required this.boxQuantity,
    required this.sheetQuantity,
    required this.productSheetPrice,
    required this.productBoxPrice,
    required this.totalBoxPrice,
    required this.totalSheetPrice,
  });

  // Converts the ReturnProductBody object into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "boxQuantity": boxQuantity,
      "sheetQuantity": sheetQuantity,
      "productSheetPrice": productSheetPrice,
      "productBoxPrice": productBoxPrice,
      "totalBoxPrice": totalBoxPrice,
      "totalSheetPrice": totalSheetPrice,
    };
  }
}
