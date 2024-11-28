class ProductModel {
  String? id;
  String? pharmacyId;
  String? drugDepotId;
  String? pharmacyName;
  String? drugDepotName;
  String? productImage;
  String? productName;
  String? barcode;
  int? boxQuantity;
  int? sheetQuantity;
  int? sheetInBox;
  double? sheetPrice;
  int? tabletInSheet;
  double? tabletPrice;
  double? costPrice;
  double? retailPrice;
  DateTime? expiryDate;
  String? description;
  String? scientificName;
  String? source;
  bool? isPaid;
  bool? isBulkImport;
  String? orderNo;
  bool? isDeleted;
  bool? isReturned;
  int? extraSheets;
  DateTime? createdAt;
  int? returnedBoxQuantity;
  int? returnedSheetQuantity;

  ProductModel(
      {required this.id,
      this.pharmacyId,
      this.drugDepotId,
      this.pharmacyName,
      this.drugDepotName,
      this.productImage,
      this.productName,
      this.barcode,
      this.boxQuantity,
      this.sheetQuantity,
      this.sheetInBox,
      this.sheetPrice,
      this.tabletInSheet,
      this.tabletPrice,
      this.costPrice,
      this.retailPrice,
      this.expiryDate,
      this.description,
      this.scientificName,
      this.source,
      this.isPaid = true,
      this.isBulkImport = false,
      this.orderNo,
      this.isDeleted = false,
      this.isReturned = false,
      this.extraSheets,
      this.returnedBoxQuantity,
      this.returnedSheetQuantity,
      this.createdAt});

  double get totalPrice {
    double boxTotal = boxQuantity! * retailPrice!;
    double sheetTotal = sheetQuantity! * (sheetPrice ?? 0.0);
    return boxTotal + sheetTotal;
  }

  // From Map (deserialization)
  factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      pharmacyId: map['pharmacyId'],
      drugDepotId: map['drugDepotId'],
      pharmacyName: map['pharmacyName'],
      drugDepotName: map['drugDepotName'],
      productImage: map['productImage'],
      productName: map['productName'],
      barcode: map['barcode'],
      boxQuantity: map['boxQuantity'],
      sheetQuantity: map['sheetQuantity'],
      sheetInBox: map['sheetInBox'],
      sheetPrice: map['sheetPrice']?.toDouble(),
      tabletInSheet: map['tabletInSheet'],
      tabletPrice: map['tabletPrice']?.toDouble(),
      costPrice: map['costPrice'].toDouble(),
      retailPrice: map['retailPrice'].toDouble(),
      expiryDate: DateTime.parse(map['expiryDate']),
      description: map['description'],
      scientificName: map['scientificName'],
      extraSheets: map['extraSheets'],
      isPaid: false,
      isBulkImport: false,
      createdAt: DateTime.parse(map['created_at']),
      isReturned: false,
      returnedBoxQuantity: map['returnedBoxQuantity'],
      returnedSheetQuantity: map['returnedSheetQuantity'],
      isDeleted: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pharmacyId': pharmacyId,
      'drugDepotId': drugDepotId,
      'pharmacyName': pharmacyName,
      'drugDepotName': drugDepotName,
      'productImage': productImage,
      'productName': productName,
      'barcode': barcode,
      'boxQuantity': boxQuantity,
      'sheetQuantity': sheetQuantity,
      'sheetInBox': sheetInBox,
      'sheetPrice': sheetPrice,
      'tabletInSheet': tabletInSheet,
      'tabletPrice': tabletPrice,
      'costPrice': costPrice,
      'retailPrice': retailPrice,
      'expiryDate': expiryDate?.toIso8601String(),
      'description': description,
      'scientificName': scientificName,
      'source': source,
      'isPaid': isPaid,
      'isBulkImport': isBulkImport,
      'orderNo': orderNo,
      'isDeleted': isDeleted,
      'extraSheets': extraSheets,
      'created_at': createdAt?.toIso8601String(),
      'isReturned': isReturned,
      'returnedBoxQuantity': returnedBoxQuantity,
      'returnedSheetQuantity': returnedSheetQuantity,
    };
  }

  // CopyWith method
  ProductModel copyWith({
    String? id,
    String? pharmacyId,
    String? drugDepotId,
    String? pharmacyName,
    String? drugDepotName,
    String? productImage,
    String? productName,
    String? barcode,
    int? boxQuantity,
    int? sheetQuantity,
    int? sheetInBox,
    double? sheetPrice,
    int? tabletInSheet,
    double? tabletPrice,
    double? costPrice,
    double? retailPrice,
    DateTime? expiryDate,
    String? description,
    String? scientificName,
    String? source,
    bool? isPaid,
    bool? isBulkImport,
    String? orderNo,
    bool? isDeleted,
    bool? isReturned,
    int? extraSheets,
    DateTime? createdAt,
    int? returnedBoxQuantity,
    int? returnedSheetQuantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      drugDepotId: drugDepotId ?? this.drugDepotId,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      drugDepotName: drugDepotName ?? this.drugDepotName,
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      barcode: barcode ?? this.barcode,
      boxQuantity: boxQuantity ?? this.boxQuantity,
      sheetQuantity: sheetQuantity ?? this.sheetQuantity,
      sheetInBox: sheetInBox ?? this.sheetInBox,
      sheetPrice: sheetPrice ?? this.sheetPrice,
      tabletInSheet: tabletInSheet ?? this.tabletInSheet,
      tabletPrice: tabletPrice ?? this.tabletPrice,
      costPrice: costPrice ?? this.costPrice,
      retailPrice: retailPrice ?? this.retailPrice,
      expiryDate: expiryDate ?? this.expiryDate,
      description: description ?? this.description,
      scientificName: scientificName ?? this.scientificName,
      source: source ?? this.source,
      isPaid: isPaid ?? this.isPaid,
      isBulkImport: isBulkImport ?? this.isBulkImport,
      orderNo: orderNo ?? this.orderNo,
      isDeleted: isDeleted ?? this.isDeleted,
      isReturned: isReturned ?? this.isReturned,
      extraSheets: extraSheets ?? this.extraSheets,
      createdAt: createdAt ?? this.createdAt,
      returnedBoxQuantity: returnedBoxQuantity ?? this.returnedBoxQuantity,
      returnedSheetQuantity:
          returnedSheetQuantity ?? this.returnedSheetQuantity,
    );
  }
}
