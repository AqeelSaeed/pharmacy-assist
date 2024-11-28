import 'product_model.dart';

class CartItem {
  final List<ProductModel> cartItems;
  double? totalAmount;

  CartItem({
    required this.cartItems,
    this.totalAmount,
  });

  double calculateTotalAmount() {
    double total = 0.0;

    for (var product in cartItems) {
      total += (product.boxQuantity ?? 0) *
              (double.tryParse(product.retailPrice.toString()) ??
                  0) + // Box total
          (product.sheetQuantity ?? 0) *
              (product.sheetPrice ?? 0); // Sheet total
    }

    return total;
  }
}
