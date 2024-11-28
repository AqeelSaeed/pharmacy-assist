import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmacy_assist/utils/shared_pref.dart';
import '../../main_barrel.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo = ProductRepo();

  List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;
  List<ProductModel> _paginatedProducts = [];
  String _searchKeyword = '';
  int _currentPage = 1;
  int totalPages = 0;

  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts(String uid) async {
    try {
      emit(ProductLoading());
      _allProducts = await productRepo.fetchProductList(uid);
      _applySearch();
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void searchProducts(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    _currentPage = 1;
    _applySearch();
  }

  void resetCubit() {
    _searchKeyword = '';
    _currentPage = 1;
    _paginatedProducts.clear();
    emit(ProductInitial()); // Reset state to initial
  }

  void _applySearch() {
    List<ProductModel> filteredProducts;

    if (_searchKeyword.isEmpty) {
      filteredProducts = _allProducts;
    } else {
      filteredProducts = _allProducts.where((product) {
        return product.productName!.toLowerCase().contains(_searchKeyword);
      }).toList();
    }

    totalPages = (filteredProducts.length / 10).ceil();
    _paginatedProducts =
        filteredProducts.skip((_currentPage - 1) * 10).take(10).toList();

    emit(ProductLoaded(_paginatedProducts, totalPages, _currentPage));
    emit(PosProductList(
      products: filteredProducts,
    ));
  }

  void changePage(int page) {
    _currentPage = page;
    _applySearch();
  }

  Future<Map<String, dynamic>> uploadFile(
      String fileName, Uint8List bytes) async {
    try {
      emit(UploadingFile());
      final result = await productRepo.uploadCsvFile(fileName, bytes);
      if (result['success'] == true) {
        emit(FileUploaded(result['message']));
        return {'success': true, 'message': result['message']};
      } else {
        emit(FileUploaded(result['message']));
        return {
          'success': false,
          'message': result['error'] ?? 'Failed to upload CSV file.'
        };
      }
    } catch (error) {
      log('Error: $error');
      emit(UploadError(error.toString()));
      return {'success': false, 'message': error.toString()};
    }
  }

  Future<void> addProduct({
    required String productName,
    required String barcode,
    required int boxQuantity,
    required int sheetInBox,
    required double costPrice,
    required double retailPrice,
    required String expiryDate,
    required String description,
    required String scientificName,
    required String source,
    required String orderNo,
    required int tableInSheet,
    required Uint8List productImage,
  }) async {
    try {
      emit(AddingProduct()); // Emit loading state
      final result = await productRepo.createProductWithImage(
          productName: productName,
          barcode: barcode,
          boxQuantity: boxQuantity,
          sheetInBox: sheetInBox,
          costPrice: costPrice,
          retailPrice: retailPrice,
          expiryDate: expiryDate,
          description: description,
          scientificName: scientificName,
          source: source,
          orderNo: orderNo,
          tableInSheet: tableInSheet,
          imageBytes: productImage,
          uid: SharedPref.getString(key: 'uid'));
      if (result['success'] == true) {
        emit(ProductAdded(result['message']));
      } else {
        emit(ProductError('Error occurred: ${result['message']['error']}'));
      }
    } catch (e) {
      emit(ProductError(
          'Error occurred: $e')); // Emit failure state for exceptions
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      emit(DeletingProduct());
      log('deleting');
      final result = await productRepo.deleteProduct(productId);
      log('deleted');

      if (result['success'] == true) {
        _allProducts = await productRepo
            .fetchProductList(SharedPref.getString(key: 'uid'));
        emit(ProductLoaded(_allProducts, totalPages, _currentPage));
        log('deleted && loaded');
      } else {
        log('deleting error');
        emit(DeleteError(result['message']));
      }
    } catch (e) {
      emit(DeleteError(e.toString()));
    }
  }

  Future<Map<String, dynamic>> updateProdcut({
    required String productId,
    required String productName,
    required String barcode,
    required double boxQuantity,
    required int sheetInBox,
    required double costPrice,
    required double retailPrice,
    required String expiryDate,
    required String description,
    required String scientificName,
    required String source,
    required String orderNo,
    required int tableInSheet,
    required bool isBuldImport,
    required bool isPaid,
    required Uint8List image,
  }) async {
    try {
      emit(AddingProduct());
      log('deleting');
      final result = await productRepo.updateProductWithImage(
          productName: productName,
          barcode: barcode,
          boxQuantity: boxQuantity,
          sheetInBox: sheetInBox,
          costPrice: costPrice,
          retailPrice: retailPrice,
          expiryDate: expiryDate,
          description: description,
          scientificName: scientificName,
          source: source,
          orderNo: orderNo,
          tableInSheet: tableInSheet,
          imageBytes: image,
          productId: productId,
          isBulkImport: isBuldImport,
          isPaid: isPaid);
      log('deleted');
      if (result['success'] == true) {
        emit(ProductAdded(result['message']));
        return {'success': true, 'message': result['message']};
      } else {
        emit(ProductError('Error occurred: ${result['message']['error']}'));
        return {
          'success': false,
          'message': result['error'] ?? 'Failed to Updated Product'
        };
      }
    } catch (e) {
      emit(ProductError(e.toString()));
      return {'success': false, 'message': e.toString()};
    }
  }
}
