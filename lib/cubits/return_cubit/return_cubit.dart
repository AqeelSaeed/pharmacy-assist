import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/cubits/return_cubit/return_state.dart';
import 'package:pharmacy_assist/models/return_product_model.dart';
import 'package:pharmacy_assist/repos/returns_repo.dart';
import 'package:http/http.dart' as http;
import '../../models/product_model.dart';
import '../../utils/constants.dart';
import '../../utils/shared_pref.dart'; // Adjust the import paths based on your project structure

class ReturnCubit extends Cubit<ReturnState> {
  ReturnsRepo repo = ReturnsRepo();
  List<Return> _allTransactions = [];
  List<Return> _paginatedTransactions = [];
  String _searchKeyword = '';
  int _currentPage = 1;
  int totalPages = 0;
  List<ProductModel> returnedProducts = [];
  double newTotal = 0.0;

  ReturnCubit() : super(ReturnInitial()) {
    initializeTransactions();
    _applySearch();
  }

  void totalAmount(double amount) {
    newTotal = amount;
    emit(TotalUpdated(newTotal));
  }

  void resetNewTotal() {
    newTotal = 0.0;
    emit(TotalUpdated(newTotal));
  }

  void returnQuantities(ProductModel item,
      {int? boxQuantity = 0, int? sheetQuantity = 0}) {
    double totalBoxReturn = 0.0;
    double totalSheetReturn = 0.0;
    int index = returnedProducts.indexWhere((product) => product.id == item.id);

    if (index != -1) {
      print('me yaha tha');
      // If the product already exists, update its quantities (REPLACE existing values)
      var existingProduct = returnedProducts[index];

      var updatedProduct = existingProduct.copyWith(
        boxQuantity: boxQuantity, // Replace the old boxQuantity with new one
        sheetQuantity:
            sheetQuantity, // Replace the old sheetQuantity with new one
      );
      returnedProducts[index] = updatedProduct;
      log('Updated Product: ${returnedProducts[index]}');
    } else {
      // Add a new product to the returned list
      var newProduct = item.copyWith(
        boxQuantity: boxQuantity,
        sheetQuantity: sheetQuantity,
      );
      returnedProducts.add(newProduct);
      log('New Product Added: $newProduct');
    }
    // Initialize totals for box and sheet separately
    print('why i m not running');
    // Recalculate the total return amounts for boxes and sheets separately
    for (var product in returnedProducts) {
      double productBoxPrice = product.retailPrice ?? 0.0;
      double productSheetPrice = product.sheetPrice ?? 0.0;

      // Calculate the total for box returns
      print('==========BoxQuantity ============ ${product.boxQuantity}');
      totalBoxReturn += (product.boxQuantity ?? 0) * productBoxPrice;
      print('============SheetQuantity ${product.sheetQuantity}');
      // Calculate the total for sheet returns
      totalSheetReturn += (product.sheetQuantity ?? 0) * productSheetPrice;
    }

    // Calculate the sum of both box and sheet totals
    double sumTotalReturn = totalBoxReturn + totalSheetReturn;

    log('Total Box Return Amount: $totalBoxReturn');
    log('Total Sheet Return Amount: $totalSheetReturn');
    log('Total Return Amount (Box + Sheet): $sumTotalReturn');

    // Emit the new total return amount
  }

  Future<void> returnProducts(
      String orderId, List<Map<String, dynamic>> productList) async {
    final url = Uri.parse(
        '${baseUrl}pharmacy/sale/return/${SharedPref.getString(key: 'uid')}/$orderId');
    log('apiUrl: $url......$orderId');

    Map<String, dynamic> body = {
      "productList": productList,
    };
    emit(ReturnLoading());
    try {
      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == true) {
          log('apiResponse: $data');
          emit(ReturnSuccess());
        } else {
          log('Error: ${data['message']}');
          emit(ReturnError('${data['message']}'));
        }
      } else {
        log('Error Response: ${response.body}');
        emit(ReturnError(response.body));
      }
    } catch (e) {
      log('Error Message: $e');
      emit(ReturnError('$e'));
    }
  }

  Future<void> returnAllSales(String orderId) async {
    try {
      var data = await repo.returnAllSales(orderId);
      if (data['success'] == true) {
        emit(SaleReturned());
      } else {
        emit(ReturnError(data['success']));
      }
    } catch (e) {
      rethrow;
    }
  }

  void initializeTransactions() async {
    emit(ReturnLoading());
    try {
      _allTransactions = await repo.fetchAllReturns();
      _applySearch();
    } catch (e) {
      emit(ReturnError(e.toString()));
    }
  }

  void searchTransactions(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    _currentPage = 1;
    _applySearch();
  }

  void _applySearch() {
    List<Return> filteredTransactions;

    if (_searchKeyword.isEmpty) {
      filteredTransactions = _allTransactions;
    } else {
      filteredTransactions = _allTransactions.where((transaction) {
        return transaction.totalPrice!.toLowerCase().contains(_searchKeyword);
      }).toList();
    }

    totalPages = (filteredTransactions.length / 10).ceil();
    _paginatedTransactions =
        filteredTransactions.skip((_currentPage - 1) * 10).take(10).toList();

    emit(ReturnLoaded(_paginatedTransactions, totalPages, _currentPage));
  }

  void changePage(int page) {
    _currentPage = page;
    _applySearch();
  }

  void resetCubit() {
    _searchKeyword = '';
    _currentPage = 1;
    _paginatedTransactions.clear();
    emit(ReturnInitial()); // Reset state to initial
  }
}
