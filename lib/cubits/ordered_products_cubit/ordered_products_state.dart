import '../../main_barrel.dart';

class OrderedProductsState {
  final List<ProductModel> orderedProducts;
  final double totalAmount;
  final List<ProductModel> updateProductList;

  OrderedProductsState({
    List<ProductModel>? orderedProducts,
    final List<ProductModel>? updateProductList,
    double? totalAmount,
  })  : orderedProducts = orderedProducts ?? [],
        updateProductList = updateProductList ?? [],
        totalAmount = totalAmount ?? 0.0;

  OrderedProductsState copyWith({
    List<ProductModel>? orderedProducts,
    List<ProductModel>? updateProductList,
    double? totalAmount,
  }) {
    return OrderedProductsState(
      orderedProducts: orderedProducts ?? this.orderedProducts,
      updateProductList: updateProductList ?? this.updateProductList,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}

class ReturningProduct extends OrderedProductsState {}

class ProductsReturned extends OrderedProductsState {
  String message;
  ProductsReturned(this.message);
}

class Error extends OrderedProductsState {
  String errorMessage;
  Error(this.errorMessage);
}
