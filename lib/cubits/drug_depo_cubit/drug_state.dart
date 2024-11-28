// Cubit State Definitions
import 'package:pharmacy_assist/main_barrel.dart';

abstract class DrugDepoState {}

class DrugDepoInitial extends DrugDepoState {}

class DrugDepoLoading extends DrugDepoState {}

class DrugDepoLoaded extends DrugDepoState {
  final List<DrugDepot> drugDepos;
  final int totalPages;
  final int currentPage;

  DrugDepoLoaded(this.drugDepos, this.totalPages, this.currentPage);
}

class DrugDepoError extends DrugDepoState {
  final String error;

  DrugDepoError(this.error);
}
