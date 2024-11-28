// Cubit Implementation
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/cubits/drug_depo_cubit/drug_state.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class DrugDepoCubit extends Cubit<DrugDepoState> {
  DrugDepoCubit() : super(DrugDepoLoading());
  final DrugDepotRepo drugRepo = DrugDepotRepo();
  List<DrugDepot> _allProducts = [];
  List<DrugDepot> _paginatedProducts = [];
  String _searchKeyword = '';
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  int totalPages = 0;

  Future<void> fetchDepots() async {
    try {
      emit(DrugDepoLoading());
      _allProducts = await drugRepo.fetchDepos();
      _applySearch();
    } catch (e) {
      emit(DrugDepoError(e.toString()));
    }
  }

  void resetCubit() {
    _searchKeyword = '';
    _currentPage = 1;
    _paginatedProducts.clear();
    emit(DrugDepoInitial()); // Reset state to initial
  }

  void searchDepos(String keyword) {
    _searchKeyword = keyword.toLowerCase();
    _currentPage = 1;
    _applySearch();
  }

  void _applySearch() {
    List<DrugDepot> filteredProducts;

    if (_searchKeyword.isEmpty) {
      filteredProducts = _allProducts;
    } else {
      filteredProducts = _allProducts.where((product) {
        return product.name!.toLowerCase().contains(_searchKeyword);
      }).toList();
    }

    totalPages = (filteredProducts.length / _itemsPerPage).ceil();
    _paginatedProducts = filteredProducts
        .skip((_currentPage - 1) * _itemsPerPage)
        .take(_itemsPerPage)
        .toList();

    emit(DrugDepoLoaded(_paginatedProducts, totalPages, _currentPage));
  }

  void changePage(int page) {
    _currentPage = page;
    _applySearch();
  }
}
