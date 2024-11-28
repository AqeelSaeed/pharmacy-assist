import '../../models/return_product_model.dart';

abstract class ReturnState {}

class ReturnInitial extends ReturnState {}

class ReturnLoading extends ReturnState {}

class ReturnSuccess extends ReturnState {}

class ReturnLoaded extends ReturnState {
  final List<Return> paginatedReturns;
  final int totalPages;
  final int currentPage;

  ReturnLoaded(this.paginatedReturns, this.totalPages, this.currentPage);
}

class ReturnListFiltered extends ReturnState {
  final List<Return> returnsList;

  ReturnListFiltered({required this.returnsList});
}

class ReturnError extends ReturnState {
  final String message;

  ReturnError(this.message);
}

class ReturningSale extends ReturnState {}

class SaleReturned extends ReturnState {}

class TotalUpdated extends ReturnState {
  final double totalAmount;

  TotalUpdated(this.totalAmount);
}
