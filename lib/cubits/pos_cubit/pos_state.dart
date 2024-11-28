import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

class POSState extends Equatable {
  final List<ProductModel> cartProducts;
  final double totalAmount;

  POSState({this.cartProducts = const []})
      : totalAmount = _calculateTotalAmount(cartProducts);

  static double _calculateTotalAmount(List<ProductModel> products) {
    double total = 0.0;
    for (var product in products) {
      final boxQuantity = product.boxQuantity ?? 0;
      final sheetQuantity = product.sheetQuantity ?? 0;
      final boxPrice = product.retailPrice ?? 0.0;
      final sheetPrice = product.sheetPrice ?? 0.0;
      total += (boxQuantity * boxPrice) + (sheetQuantity * sheetPrice);
    }
    return total;
  }

  @override
  List<Object> get props => [cartProducts, totalAmount];
}

class CheckingOut extends POSState {}

class Checkedout extends POSState {
  final String successMessage;
  final String saleId;
  final bool success;
  Checkedout(
      {required this.successMessage,
      required this.saleId,
      required this.success});
}

class CheckoutError extends POSState {
  final String errorMessage;

  CheckoutError(this.errorMessage);
}
