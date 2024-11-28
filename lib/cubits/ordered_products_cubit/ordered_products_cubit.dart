import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main_barrel.dart';
import 'ordered_products_state.dart';

class OrderedProductsCubit extends Cubit<OrderedProductsState> {
  int totalBoxes = 0;
  int totalSheets = 0;
  OrderedProductsCubit()
      : super(OrderedProductsState(orderedProducts: [], totalAmount: 0.0));

  void loadProducts(List<ProductModel> products, BuildContext context) {
    emit(state.copyWith(
      orderedProducts: products,
      updateProductList: products,
      totalAmount: calculateTotalCartAmount(products),
    ));
  }

  void updateBoxQuantity(ProductModel item, int quantity) {
    final updatedItems = state.orderedProducts.map((product) {
      if (product == item) {
        return product.copyWith(boxQuantity: quantity);
      }
      return product;
    }).toList();
    totalBoxes = quantity;
    log('boxQty: $totalBoxes');
    emit(state.copyWith(
      updateProductList: updatedItems,
      totalAmount: calculateTotalCartAmount(updatedItems),
    ));
  }

  void updateSheetQuantity(ProductModel item, int quantity) {
    final updatedItems = state.orderedProducts.map((product) {
      if (product == item) {
        return product.copyWith(sheetQuantity: quantity);
      }
      return product;
    }).toList();
    totalSheets = quantity;
    log('sheetQty: $totalSheets');
    emit(state.copyWith(
      updateProductList: updatedItems,
      totalAmount: calculateTotalCartAmount(updatedItems),
    ));
  }

  double calculateTotalCartAmount(List<ProductModel> cartItems) {
    double total = cartItems.fold(0.0, (sum, item) {
      double itemTotal = (item.boxQuantity! * item.retailPrice!) +
          (item.sheetQuantity! * item.sheetPrice!);
      log('Item: ${item.productName}, Box: ${item.boxQuantity}, Box Price: ${item.retailPrice}, '
          'Sheet: ${item.sheetQuantity}, Sheet Price: ${item.sheetPrice}, Item Total: $itemTotal');
      return sum + itemTotal;
    });
    log('Total Cart Amount: $total');
    return total;
  }
}
