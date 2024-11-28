import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'pos_state.dart';

class POSCubit extends Cubit<POSState> {
  POSCubit() : super(POSState());

  void addToCart(ProductModel product) {
    final existingProductIndex =
        state.cartProducts.indexWhere((item) => item.id == product.id);

    if (existingProductIndex != -1) {
      final existingProduct = state.cartProducts[existingProductIndex];

      final updatedProduct = ProductModel(
        id: existingProduct.id,
        productName: product.productName,
        retailPrice: existingProduct.retailPrice,
        sheetPrice: existingProduct.sheetPrice,
        boxQuantity:
            (existingProduct.boxQuantity ?? 0) + (product.boxQuantity ?? 0),
        sheetQuantity:
            (existingProduct.sheetQuantity ?? 0) + (product.sheetQuantity ?? 0),
        // Copy other necessary fields if any
      );

      final updatedCart = List<ProductModel>.from(state.cartProducts)
        ..[existingProductIndex] = updatedProduct;

      emit(POSState(cartProducts: updatedCart));
    } else {
      final newProduct = ProductModel(
        id: product.id,
        productName: product.productName,
        retailPrice: product.retailPrice,
        sheetPrice: product.sheetPrice,
        boxQuantity: 1,
        sheetQuantity: product.sheetQuantity ?? 0,
      );

      emit(POSState(cartProducts: [...state.cartProducts, newProduct]));
    }
  }

  void clearCart() {
    emit(POSState(cartProducts: const []));
  }

  void removeFromCart(String productId) {
    final updatedCart =
        state.cartProducts.where((product) => product.id != productId).toList();
    emit(POSState(cartProducts: updatedCart));
  }

  void updateProductQuantity(ProductModel product,
      {int? boxQuantity, int? sheetQuantity}) {
    final updatedCart = state.cartProducts.map((cartProduct) {
      if (cartProduct.id == product.id) {
        final currentBoxQuantity = cartProduct.boxQuantity ?? 0;
        final currentSheetQuantity = cartProduct.sheetQuantity ?? 0;
        final newBoxQuantity = boxQuantity ?? currentBoxQuantity;
        final newSheetQuantity = sheetQuantity ?? currentSheetQuantity;

        // Create a new instance of ProductModel instead of modifying the existing one
        return ProductModel(
          id: cartProduct.id,
          productName: product.productName,
          retailPrice: cartProduct.retailPrice,
          sheetPrice: cartProduct.sheetPrice,
          boxQuantity: newBoxQuantity,
          sheetQuantity: newSheetQuantity,
          // Include any other fields you need to copy
        );
      }
      return cartProduct; // Return unchanged product
    }).toList();

    emit(POSState(cartProducts: updatedCart));
  }

  Future<Map<String, dynamic>> checkout(
      {required String customerName,
      required List<ProductModel> list,
      required double totalAmount}) async {
    emit(CheckingOut());
    final result = await POSTransactionRepo().checkoutOrder(
        customerName: customerName, list: list, totalAmount: totalAmount);
    try {
      if (result['success'] == true) {
        emit(Checkedout(
            successMessage: result['message'],
            saleId: result['sale'],
            success: result['success']));

        return {
          'success': true,
          'message': result['message'],
          'sale': result['sale']
        };
      } else {
        emit(CheckoutError(result['error']));
        return {'success': false, 'message': result['error']};
      }
    } catch (error) {
      emit(CheckoutError(result['message']));
      return {'success': false, 'message': result['message']};
    }
  }
}
