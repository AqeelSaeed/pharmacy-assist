import 'package:pharmacy_assist/main_barrel.dart';

abstract class SalesState {}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<Sale> paginatedSales;
  final int totalPages;
  final int currentPage;

  SalesLoaded(this.paginatedSales, this.totalPages, this.currentPage);
}

class SalesListFiltered extends SalesState {
  final List<Sale> sales;

  SalesListFiltered({required this.sales});
}

class SalesError extends SalesState {
  final String message;
  SalesError(this.message);
}
