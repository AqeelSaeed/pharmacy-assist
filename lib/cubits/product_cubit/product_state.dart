part of 'product_cubit.dart';

sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final int totalPages; // Add totalPages field
  final int currentPage; // Add currentPage field

  ProductLoaded(this.products, this.totalPages, this.currentPage);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}

///============== Add Product =======================
class AddingProduct extends ProductState {}

class ProductAdded extends ProductState {
  final String message;
  ProductAdded(this.message);
}

/// ============= Delete Product ===================
class DeletingProduct extends ProductState {}

class ProductDeleted extends ProductState {
  final String message;
  ProductDeleted(this.message);
}

class DeleteError extends ProductState {
  final String error;

  DeleteError(this.error);
}

//================ Upload CSV File -====----==================

class UploadingFile extends ProductState {}

class FileUploaded extends ProductState {
  final String message;
  FileUploaded(this.message);
}

class UploadError extends ProductState {
  final String error;

  UploadError(this.error);
}

class PosProductList extends ProductState {
  final List<ProductModel> products;

  PosProductList({required this.products});
}
