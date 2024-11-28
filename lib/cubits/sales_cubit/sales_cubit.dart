import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:pharmacy_assist/cubits/sales_cubit/sales_state.dart';
import 'package:pharmacy_assist/main_barrel.dart';
import 'package:pharmacy_assist/repos/sales_repo.dart';

class SalesCubit extends Cubit<SalesState> {
  final SalesRepo repo = SalesRepo();
  List<Sale> _allSales = [];
  List<Sale> _paginatedSales = [];
  String _searchKeyword = '';
  int _currentPage = 1;
  int totalPages = 0;

  SalesCubit() : super(SalesInitial()) {
    fetchAllSales();
    _applySearch();
  }

  Future<void> fetchAllSales() async {
    try {
      emit(SalesLoading());

      _allSales = await repo.fetchSales();
      _applySearch();
    } catch (e) {
      log('cubit error');
      emit(SalesError(e.toString()));
    }
  }

  void searchSales(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    _currentPage = 1;
    _applySearch();
  }

  void _applySearch() {
    List<Sale> filteredSales;

    if (_searchKeyword.isEmpty) {
      filteredSales = _allSales;
    } else {
      filteredSales = _allSales.where((sale) {
        return sale.customerName!.toLowerCase().contains(_searchKeyword) ||
            sale.saleId!.toLowerCase().contains(_searchKeyword);
      }).toList();
    }

    totalPages = (filteredSales.length / 10).ceil();
    _paginatedSales =
        filteredSales.skip((_currentPage - 1) * 10).take(10).toList();

    emit(SalesLoaded(_paginatedSales, totalPages, _currentPage));
  }

  void changePage(int page) {
    _currentPage = page;
  }

  void resetCubit() {
    _searchKeyword = '';
    _currentPage = 1;
    _paginatedSales.clear();
    emit(SalesInitial());
  }

  void printCustomListDetails(List<ProductModel> products) {
    for (int i = 0; i < products.length; i++) {
      log('Index: $i, Product ID: ${products[i].id}, Type: ${products[i].runtimeType}');
    }
  }
}
